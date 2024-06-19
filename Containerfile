ARG PYTHON_VERSION=3.12
FROM python:${PYTHON_VERSION}-slim-bookworm as builder

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
COPY --link files/scripts/* /
COPY --link files/src /src

ADD https://github.com/mitogen-hq/mitogen/archive/refs/tags/v0.3.7.tar.gz /mitogen.tar.gz

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3003
RUN <<EOF
set -e
set -x

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

python3 -m pip install --no-cache-dir --upgrade 'pip==24.0'
pip install --no-cache-dir -r /src/requirements.txt

# add user
groupadd -g "$GROUP_ID" dragon
groupadd -g "$GROUP_ID_DOCKER" docker
useradd -l -g dragon -G docker -u "$USER_ID" -m -d /ansible dragon

# prepare release repository
git clone https://github.com/osism/release /release

# run preparations
python3 /src/render-python-requirements.py

# install required python packages
pip install --no-cache-dir -r /requirements.txt

# create required directories
mkdir -p \
  /interface \
  /share

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

# install kubectl
KUBECTL_VERSION=1.29.1
curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
chmod +x /usr/local/bin/kubectl

# prepare .kube directory
mkdir -p /ansible/.kube
ln -s /share/kubeconfig /ansible/.kube/config
chown -R dragon: /ansible/.kube

# copy ara configuration
python3 -m ara.setup.env >> /ansible/ara.env

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

ARG PYTHON_VERSION=3.12
FROM python:${PYTHON_VERSION}-slim-bookworm

COPY --link --from=builder / /
USER dragon
WORKDIR /ansible
ENTRYPOINT ["/entrypoint.sh"]
