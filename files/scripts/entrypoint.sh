#!/usr/bin/env bash

mkdir -p /interface/kolla-ansible /interface/versions /interface/overlays /interface/playbooks

rsync -am --exclude='requirements*.yml' --include='*.yml' --exclude='*' /ansible/ /interface/osism-kubernetes/
cp /ansible/group_vars/all/versions.yml /interface/versions/osism-kubernetes.yml
cp /ansible/playbooks.yml /interface/playbooks/osism-kubernetes.yml

exec /usr/bin/dumb-init -- "$@"
