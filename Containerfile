ARG PYTHON_VERSION=3.13
FROM python:${PYTHON_VERSION}-slim-bookworm AS builder

ARG VERSION=latest
ARG USER_ID=45000
ARG GROUP_ID=45000
ARG GROUP_ID_DOCKER=999

ENV DEBIAN_FRONTEND=noninteractive

USER root

COPY --link charts /charts
COPY --link playbooks/* /ansible/
COPY --link roles /ansible/roles

COPY --link files/ansible.cfg /etc/ansible/ansible.cfg
COPY --link files/ara.env /ansible/ara.env
COPY --link files/requirements.yml /ansible/requirements.yml
COPY --link files/scripts/* /
COPY --link files/src /src

ADD https://github.com/mitogen-hq/mitogen/archive/refs/tags/v0.3.22.tar.gz /mitogen.tar.gz

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3003
RUN <<EOF
set -e
set -x

CAPI_VERSION=1.8.5
CILIUM_CLI_VERSION=v0.16.20
KUBECTL_VERSION=1.30.7
OPERATOR_SDK_VERSION=v1.38.0

# shellcheck disable=SC2046
ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)

# show motd
echo "[ ! -z \"\$TERM\" -a -r /etc/motd ] && cat /etc/motd" >> /etc/bash.bashrc

# install required packages
apt-get update
apt-get install --no-install-recommends -y \
  build-essential \
  curl \
  dumb-init \
  git \
  gnupg \
  gnupg-agent \
  iputils-ping \
  jq \
  libffi-dev \
  libssh-dev \
  libssl-dev \
  libyaml-dev \
  openssh-client \
  procps \
  rsync \
  sshpass
update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3 1
update-alternatives --install /usr/bin/python python /usr/local/bin/python 1

python3 -m pip install --no-cache-dir --upgrade 'pip==24.3.1'
pip install --no-cache-dir -r /src/requirements.txt

# add user
groupadd -g "$GROUP_ID" dragon
groupadd -g "$GROUP_ID_DOCKER" docker
useradd -l -g dragon -G docker -u "$USER_ID" -m -d /ansible dragon

# prepare release repository
git clone https://github.com/osism/release /release

# prepare project repository
git clone https://github.com/osism/defaults /defaults
( cd /defaults || exit; git fetch --all --force; git checkout "$(yq -M -r .defaults_version "/release/$VERSION/base.yml")" )

git clone https://github.com/osism/cfg-generics /generics
( cd /generics || exit; git fetch --all --force; git checkout "$(yq -M -r .generics_version "/release/$VERSION/base.yml")" )

# add inventory files
mkdir -p /ansible/inventory.generics /ansible/inventory
cp /generics/inventory/* /ansible/inventory.generics

# run preparations
mkdir -p /ansible/group_vars/all/

python3 /src/render-python-requirements.py
python3 /src/render-versions.py

# install required python packages
pip install --no-cache-dir -r /requirements.txt

# set ansible version in the motd
ansible_version=$(python3 -c 'import ansible; print(ansible.release.__version__)')
sed -i -e "s/ANSIBLE_VERSION/$ansible_version/" /etc/motd

# create required directories
mkdir -p \
  /ansible \
  /ansible/action_plugins \
  /ansible/cache \
  /ansible/logs \
  /ansible/secrets \
  /interface \
  /share

# install required ansible collections & roles
ansible-galaxy collection install -v -f -r /ansible/requirements.yml -p /usr/share/ansible/collections

# install mitogen ansible plugin
mkdir -p /usr/share/mitogen
tar xzf /mitogen.tar.gz --strip-components=1 -C /usr/share/mitogen
rm -rf /usr/share/mitogen/{tests,docs,.ci,.lgtm.yml,.travis.yml}
rm /mitogen.tar.gz

# install helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update
apt-get install --no-install-recommends -y \
  helm

# install helm plugins
helm plugin install https://github.com/databus23/helm-diff

# install cilium CLI
curl -L --fail --remote-name-all "https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${ARCH}.tar.gz{,.sha256sum}"
sha256sum --check "cilium-linux-${ARCH}.tar.gz.sha256sum"
tar xzvfC "cilium-linux-${ARCH}.tar.gz" /usr/local/bin
rm cilium-linux-"${ARCH}".tar.gz{,.sha256sum}

# install operator-sdk
OS=$(uname | awk '{print tolower($0)}')
OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}

curl -LO "${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}"
gpg --keyserver keyserver.ubuntu.com --recv-keys 052996E2A20B5C7E
curl -LO "${OPERATOR_SDK_DL_URL}/checksums.txt"
curl -LO "${OPERATOR_SDK_DL_URL}/checksums.txt.asc"
gpg -u "Operator SDK (release) <cncf-operator-sdk@cncf.io>" --verify checksums.txt.asc
grep "operator-sdk_${OS}_${ARCH}" checksums.txt | sha256sum -c -
chmod +x "operator-sdk_${OS}_${ARCH}"
mv "operator-sdk_${OS}_${ARCH}" /usr/local/bin/operator-sdk
rm checksums.txt.asc
rm checksums.txt

# install clusterctl
curl -Lo /usr/local/bin/clusterctl https://github.com/kubernetes-sigs/cluster-api/releases/download/v${CAPI_VERSION}/clusterctl-linux-amd64
chmod +x /usr/local/bin/clusterctl

# install kubectl
curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
chmod +x /usr/local/bin/kubectl

# prepare .kube directory
mkdir -p /ansible/.kube
ln -s /share/kubeconfig /ansible/.kube/config
chown -R dragon: /ansible/.kube

# prepare .cache directory
mkdir -p /ansible/.cache
mv /root/.cache/helm /ansible/.cache
chown -R dragon: /ansible/.cache

# prepare  .local directory
mkdir -p /ansible/.local/share
mv /root/.local/share/helm /ansible/.local/share
chown -R dragon: /ansible/.local

# add symlink to /etc/openstack
ln -s /opt/configuration/environments/openstack /etc/openstack

# copy ara configuration
python3 -m ara.setup.env >> /ansible/ara.env

# prepare list of playbooks
python3 /src/render-playbooks.py

# set correct permssions
chown -R dragon: /ansible /share /interface

# cleanup
apt-get clean
apt-get remove -y \
  build-essential \
  curl \
  git \
  gnupg \
  libffi-dev \
  libssh-dev \
  libssl-dev \
  libyaml-dev
apt-get autoremove -y
rm -rf \
  /root/.cache \
  /tmp/* \
  /usr/share/doc/* \
  /usr/share/man/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

pip install --no-cache-dir pyclean==3.0.0
pyclean /usr
pip uninstall -y pyclean
EOF

USER dragon

ARG PYTHON_VERSION=3.13
FROM python:${PYTHON_VERSION}-slim-bookworm

COPY --link --from=builder / /

ENV PYTHONWARNINGS="ignore::UserWarning"
ENV KUBECONFIG="/share/kubeconfig"

VOLUME ["/share", "/interface"]
USER dragon
WORKDIR /ansible
ENTRYPOINT ["/entrypoint.sh"]
