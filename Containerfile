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

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3003
RUN <<EOF
# add user
groupadd -g "$GROUP_ID" dragon
groupadd -g "$GROUP_ID_DOCKER" docker
useradd -l -g dragon -G docker -u "$USER_ID" -m -d /ansible dragon

# create required directories
mkdir -p \
  /interface \
  /share

# set correct permssions
chown -R dragon: /ansible /share /interface
EOF

USER dragon

ARG PYTHON_VERSION=3.12
FROM python:${PYTHON_VERSION}-slim-bookworm

COPY --link --from=builder / /
USER dragon
