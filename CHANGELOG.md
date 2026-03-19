# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

This file was started on April 08, 2025. Changes prior to this date are not included in the CHANGELOG.

## [v0.20260319.0] - 2026-03-19

### Added
- Support fast inventory directory as alternative to hosts.yml (osism/osism-kubernetes#278)

### Removed
- Bundled ingress-nginx and kubernetes-dashboard Helm charts (osism/osism-kubernetes#274)
- Defaults repository from container build (osism/osism-kubernetes#279)

### Dependencies
- kubernetes.core 6.2.0 → 6.3.0 (osism/osism-kubernetes#273)
- community.general 11.4.4 → 11.4.5 (osism/osism-kubernetes#275)
- ghcr.io/astral-sh/uv 0.9.27 → 0.10.10 (osism/osism-kubernetes#272, osism/osism-kubernetes#276)
- osism.commons 0.20260127.0 → 0.20260318.0 (osism/osism-kubernetes#277, osism/osism-kubernetes#281)

## [v0.20260129.0] - 2026-01-29

### Dependencies
- mitogen → v0.3.39 (osism/osism-kubernetes#271)

## [v0.20260128.0] - 2026-01-28

### Dependencies
- ghcr.io/astral-sh/uv 0.9.16 → 0.9.27 (osism/osism-kubernetes#264, osism/osism-kubernetes#266, osism/osism-kubernetes#267, osism/osism-kubernetes#269)
- ansible.utils 6.0.0 → 6.0.1 (osism/osism-kubernetes#268)
- community.general 11.4.2 → 11.4.4 (osism/osism-kubernetes#265)
- osism.commons 0.20251126.0 → 0.20260127.0 (osism/osism-kubernetes#270)

## [v0.20251208.0] - 2025-12-08

### Dependencies
- community.general 11.4.1 → 11.4.2 (osism/osism-kubernetes#263)
- ghcr.io/astral-sh/uv 0.9.13 → 0.9.16 (osism/osism-kubernetes#262)

## [v0.20251130.0] - 2025-11-30

No changes from v0.20251127.0.

## [v0.20251127.0] - 2025-11-27

### Added
- k3s: Tmp directory creation task for cilium setup (osism/osism-kubernetes#259)

### Fixed
- Container /ansible directory permissions with Docker 29.0.0 (osism/osism-kubernetes#254)
- k3s: Tmp directory ownership set to dragon instead of root (osism/osism-kubernetes#261)

### Removed
- Mitogen Ansible plugin (osism/osism-kubernetes#260)

### Dependencies
- osism.commons 0.20251022.0 → 0.20251126.0 (osism/osism-kubernetes#255, osism/osism-kubernetes#257)
- community.general 11.4.0 → 11.4.1 (osism/osism-kubernetes#252)
- ghcr.io/astral-sh/uv 0.9.6 → 0.9.13 (osism/osism-kubernetes#248, osism/osism-kubernetes#256)

## [v0.20251101.0] - 2025-11-01

### Added
- `osism_kubernetes_version` parameter for tracking the manager version (osism/osism-kubernetes#229)
- Support for Kubernetes 1.34+ control-plane node labels in k3s_server role (osism/osism-kubernetes#238)
- `EXP_KUBEADM_BOOTSTRAP_FORMAT_IGNITION` environment variable in clusterapi play (osism/osism-kubernetes#245)
- Giltfile.yaml for syncing openstack-resource-controller install manifest (osism/osism-kubernetes#244)

### Changed
- Import k3s roles directly into the repository instead of cloning from osism/k3s-ansible at build time (osism/osism-kubernetes#235)
- Only apply k3s custom registry tasks when `custom_registries_yaml` is defined and non-empty (osism/osism-kubernetes#237)
- Remove `registries.yaml` when no custom registries are configured (osism/osism-kubernetes#239)
- Use client version instead of server version for Kubernetes version detection in k3s_server (osism/osism-kubernetes#240)
- Renamed install-korc.yaml to install-orc.yaml for openstack-resource-controller (osism/osism-kubernetes#244)
- Updated Cluster API versions: capi 1.10.3 → 1.11.2, capo 0.12.4 → 0.13.0 (osism/osism-kubernetes#243)

### Fixed
- Constrained Python version to 3.13 for aiopath compatibility to avoid multiple inheritance conflicts with Python 3.14 (osism/osism-kubernetes#249)

### Removed
- Patches for k3s_server_post (cilium.patch, metallb.patch) as changes are now included directly in the imported roles (osism/osism-kubernetes#235)
- Cilium CLI installation from k3s server post tasks, as Cilium is already part of the container image (osism/osism-kubernetes#241)

### Dependencies
- argo-cd 8.3.9 → 9.0.5 (osism/osism-kubernetes#251)
- CAPI 1.10.3 → 1.11.2 (osism/osism-kubernetes#236)
- cert-manager 1.18.2 → 1.19.1 (osism/osism-kubernetes#251)
- cert-manager-crds 1.18.1 → 1.19.1 (osism/osism-kubernetes#251)
- cloudnative-pg 0.26.0 → 0.26.1 (osism/osism-kubernetes#251)
- community.general 11.3.0 → 11.4.0 (osism/osism-kubernetes#231)
- ghcr.io/astral-sh/uv 0.8.22 → 0.9.6 (osism/osism-kubernetes#230, osism/osism-kubernetes#234, osism/osism-kubernetes#247)
- headlamp 0.35.0 → 0.37.0 (osism/osism-kubernetes#251)
- ingress-nginx 4.13.2 → 4.13.3 (osism/osism-kubernetes#251)
- kube-prometheus-stack 77.7.0 → 79.1.0 (osism/osism-kubernetes#251)
- kubernetes-dashboard 7.13.0 → 7.14.0 (osism/osism-kubernetes#251)
- kubernetes.core 6.1.0 → 6.2.0 (osism/osism-kubernetes#232)
- mariadb-operator 25.8.3 → 25.10.2 (osism/osism-kubernetes#251)
- mariadb-operator-crds 25.8.3 → 25.10.2 (osism/osism-kubernetes#251)
- memcached 7.9.7 → 8.1.1 (osism/osism-kubernetes#251)
- node-feature-discovery 0.17.3 → 0.18.2 (osism/osism-kubernetes#251)
- opensearch 3.2.1 → 3.3.2 (osism/osism-kubernetes#251)
- osism.commons 0.20250927.0 → 0.20251022.0 (osism/osism-kubernetes#233, osism/osism-kubernetes#246)
- prometheus-operator-crds 23.0.0 → 24.0.1 (osism/osism-kubernetes#251)
- prometheus-pushgateway 3.4.1 → 3.4.2 (osism/osism-kubernetes#251)
- redis-operator 0.22.0 → 0.22.2 (osism/osism-kubernetes#251)
- rook-ceph 1.18.2 → 1.18.6 (osism/osism-kubernetes#251)
- rook-ceph-cluster 1.18.2 → 1.18.6 (osism/osism-kubernetes#251)
- teleport-cluster 18.2.1 → 18.3.0 (osism/osism-kubernetes#251)
- teleport-kube-agent 18.2.1 → 18.3.0 (osism/osism-kubernetes#251)

## [v0.20250927.0] - 2025-09-27

### Dependencies
- ghcr.io/astral-sh/uv 0.8.19 → 0.8.22 (osism/osism-kubernetes#225)
- osism.commons 0.20250824.0 → 0.20250927.0 (osism/osism-kubernetes#228)
- pyyaml 6.0.2 → 6.0.3 (osism/osism-kubernetes#227)

## [v0.20250920.0] - 2025-09-20

### Dependencies
- ghcr.io/astral-sh/uv 0.8.14 → 0.8.19 (osism/osism-kubernetes#220, osism/osism-kubernetes#224)

## [v0.20250916.0] - 2025-09-16

### Added
- Container image signing with cosign in Zuul CI pipeline (osism/osism-kubernetes#208)
- Allow skipping K3s downloads with `k3s_skip_download` parameter (osism/osism-kubernetes#213)

### Changed
- Switch Helm repository from baltocdn.com to packages.buildkite.com (osism/osism-kubernetes#222)
- Sync all Helm charts to latest versions (osism/osism-kubernetes#223)

### Dependencies
- ansible.posix 2.0.0 → 2.1.0 (osism/osism-kubernetes#211)
- argo-cd 8.1.3 → 8.3.9 (osism/osism-kubernetes#223)
- cds-operator 0.20250602.0 → 0.20250904.0 (osism/osism-kubernetes#223)
- cinder-operator 0.20250602.0 → 0.20250904.0 (osism/osism-kubernetes#223)
- cloudnative-pg 0.24.0 → 0.26.0 (osism/osism-kubernetes#223)
- community.general 11.0.0 → 11.3.0 (osism/osism-kubernetes#210, osism/osism-kubernetes#212, osism/osism-kubernetes#214, osism/osism-kubernetes#216, osism/osism-kubernetes#221)
- crds (yaook) 0.20250602.0 → 0.20250904.0 (osism/osism-kubernetes#223)
- ghcr.io/astral-sh/uv 0.7.20 → 0.8.14 (osism/osism-kubernetes#209, osism/osism-kubernetes#215)
- glance-operator 0.20250602.0 → 0.20250904.0 (osism/osism-kubernetes#223)
- headlamp 0.32.1 → 0.35.0 (osism/osism-kubernetes#223)
- horizon-operator 0.20250602.0 → 0.20250904.0 (osism/osism-kubernetes#223)
- infra-operator 0.20250602.0 → 0.20250904.0 (osism/osism-kubernetes#223)
- ingress-nginx 4.13.0 → 4.13.2 (osism/osism-kubernetes#223)
- keycloak 24.7.6 → 25.2.0 (osism/osism-kubernetes#223)
- keystone-operator 0.20250602.0 → 0.20250904.0 (osism/osism-kubernetes#223)
- keystone-resources-operator 0.20250602.0 → 0.20250904.0 (osism/osism-kubernetes#223)
- kube-prometheus-stack 75.9.0 → 77.7.0 (osism/osism-kubernetes#223)
- kubernetes.core 6.0.0 → 6.1.0 (osism/osism-kubernetes#217)
- mariadb-operator 0.38.1 → 25.8.3 (osism/osism-kubernetes#223)
- mariadb-operator-crds 0.38.1 → 25.8.3 (osism/osism-kubernetes#223)
- memcached 7.9.2 → 7.9.7 (osism/osism-kubernetes#223)
- octavia-operator 0.20250602.0 → 0.20250904.0 (osism/osism-kubernetes#223)
- opensearch 3.1.0 → 3.2.1 (osism/osism-kubernetes#223)
- osism.commons 0.20250623.0 → 0.20250824.0 (osism/osism-kubernetes#218, osism/osism-kubernetes#219)
- prometheus-operator-crds 21.0.0 → 23.0.0 (osism/osism-kubernetes#223)
- prometheus-pushgateway 3.4.0 → 3.4.1 (osism/osism-kubernetes#223)
- pxc-operator 1.17.0 → 1.18.0 (osism/osism-kubernetes#223)
- rabbitmq-cluster-operator 4.4.25 → 4.4.34 (osism/osism-kubernetes#223)
- redis-operator 0.21.2 → 0.22.0 (osism/osism-kubernetes#223)
- rook-ceph 1.17.5 → 1.18.2 (osism/osism-kubernetes#223)
- rook-ceph-cluster 1.17.5 → 1.18.2 (osism/osism-kubernetes#223)
- teleport-cluster 18.0.0 → 18.2.1 (osism/osism-kubernetes#223)
- teleport-kube-agent 18.0.0 → 18.2.1 (osism/osism-kubernetes#223)

## [v0.20250711.0] - 2025-07-11

### Added
- Script to update chart versions (osism/osism-kubernetes#192)
- headlamp: ServiceAccount and ClusterRoleBinding with cluster-admin permissions (osism/osism-kubernetes#194)
- Install k-orc (Kubernetes OpenStack Resource Controller) in the kubernetes-clusterapi play (osism/osism-kubernetes#199)
- Apply cert-manager role in the kubernetes-clusterapi play (osism/osism-kubernetes#200)
- ot-container-kit/redis-operator Helm chart (version 0.21.1) (osism/osism-kubernetes#204)

### Changed
- Configure headlamp service type as LoadBalancer (osism/osism-kubernetes#193)
- Bump tool versions: hubble v1.17.2 → v1.17.5, capi 1.9.6 → 1.10.3, cilium-cli v0.18.3 → v0.18.5, flux v2.5.1 → v2.6.3, kubectl 1.32.3 → 1.33.2, operator-sdk v1.39.2 → v1.40.0 (osism/osism-kubernetes#191)
- Update keycloak-operator CRDs to version 26.3.0 (osism/osism-kubernetes#197)
- Move cert-manager CRDs from generic crds role to the cert_manager role (osism/osism-kubernetes#201)
- Move mariadb-operator CRDs from generic crds role to the mariadb_operator role (osism/osism-kubernetes#202)
- Move yaook-operators CRDs from generic crds role to the yaook_operators role (osism/osism-kubernetes#203)

### Fixed
- Fix task order in headlamp role to deploy helm chart before applying ServiceAccount and ClusterRoleBinding (osism/osism-kubernetes#195)
- Fix mariadb-operator image tag version (0.36.0 → 0.38.1) (osism/osism-kubernetes#196)
- Fix CAPI/CAPO versions in kubernetes-clusterapi play (CAPI 1.8.1 → 1.10.3, CAPO 0.10.4 → 0.12.4) (osism/osism-kubernetes#198)
- k3s_server_post patches consolidated and corrected for Cilium delegation and file ownership (osism/osism-kubernetes#207)

### Dependencies
- kubernetes.core 5.3.0 → 6.0.0 (osism/osism-kubernetes#182)
- community.general 10.7.0 → 11.0.0 (osism/osism-kubernetes#186)
- osism.commons 0.20250529.0 → 0.20250623.0 (osism/osism-kubernetes#188)
- ghcr.io/astral-sh/uv 0.7.8 → 0.7.20 (osism/osism-kubernetes#181, osism/osism-kubernetes#183, osism/osism-kubernetes#184, osism/osism-kubernetes#187, osism/osism-kubernetes#189, osism/osism-kubernetes#190, osism/osism-kubernetes#205)
- opensearch chart 2.32.0 → 3.1.0 (osism/osism-kubernetes#192)
- teleport-cluster chart 17.0.2 → 18.0.0 (osism/osism-kubernetes#192)
- teleport-kube-agent chart 17.0.2 → 18.0.0 (osism/osism-kubernetes#192)
- ingress-nginx chart 4.12.1 → 4.13.0 (osism/osism-kubernetes#192, osism/osism-kubernetes#206)
- cert-manager chart 1.15.3 → 1.18.2 (osism/osism-kubernetes#192)
- cert-manager-crds chart 1.15.0 → 1.18.1 (osism/osism-kubernetes#192)
- argo-cd chart 7.5.0 → 8.1.3 (osism/osism-kubernetes#192, osism/osism-kubernetes#206)
- memcached chart 7.4.12 → 7.9.2 (osism/osism-kubernetes#192, osism/osism-kubernetes#206)
- node-feature-discovery chart 0.16.4 → 0.17.3 (osism/osism-kubernetes#192)
- prometheus-pushgateway chart 2.14.0 → 3.4.0 (osism/osism-kubernetes#192)
- keycloak chart 24.6.3 → 24.7.6 (osism/osism-kubernetes#192, osism/osism-kubernetes#206)
- pxc-operator chart 1.15.0 → 1.17.0 (osism/osism-kubernetes#192)
- cloudnative-pg chart 0.22.0 → 0.24.0 (osism/osism-kubernetes#192)
- rook-ceph chart 1.16.6 → 1.17.5 (osism/osism-kubernetes#192)
- rook-ceph-cluster chart 1.16.6 → 1.17.5 (osism/osism-kubernetes#192)
- mariadb-operator chart 0.36.0 → 0.38.1 (osism/osism-kubernetes#192)
- mariadb-operator-crds chart 0.36.0 → 0.38.1 (osism/osism-kubernetes#192)
- rabbitmq-cluster-operator chart 4.4.6 → 4.4.25 (osism/osism-kubernetes#192, osism/osism-kubernetes#206)
- kube-prometheus-stack chart 62.3.1 → 75.9.0 (osism/osism-kubernetes#192, osism/osism-kubernetes#206)
- prometheus-operator-crds chart 14.0.0 → 21.0.0 (osism/osism-kubernetes#192)
- kubernetes-dashboard chart 7.5.0 → 7.13.0 (osism/osism-kubernetes#192)
- headlamp chart 0.24.0 → 0.32.1 (osism/osism-kubernetes#192)
- redis-operator chart 0.21.1 → 0.21.2 (osism/osism-kubernetes#206)
- yaook operator charts (cds-operator, crds, infra-operator, keystone-operator, keystone-resources-operator, cinder-operator, glance-operator, horizon-operator, octavia-operator) 0.20250512.1 → 0.20250602.0 (osism/osism-kubernetes#192)

## [v0.20250530.0] - 2025-05-30

### Added
- Octavia operator chart for Yaook (osism/osism-kubernetes#156)
- Kubernetes monitoring play and role with dnation-kubernetes-monitoring-stack and optional OpenStack exporter support (osism/osism-kubernetes#158)
- Hubble CLI v1.17.2 to container image (osism/osism-kubernetes#160)
- OpenSearch helm chart (version 2.32.0) (osism/osism-kubernetes#164)

### Changed
- Updated Yaook CRDs with support for OpenStack releases 2023.1, 2023.2, and 2024.1 (osism/osism-kubernetes#156)
- Use image cache for container builds (osism/osism-kubernetes#170)
- Refresh Zuul secrets (osism/osism-kubernetes#169)

### Fixed
- Use correct location for image cache (osism/osism-kubernetes#171)

### Dependencies
- ansible.utils 5.1.2 → 6.0.0 (osism/osism-kubernetes#155)
- capi 1.8.5 → 1.9.6 (osism/osism-kubernetes#157)
- cephcsi v3.13.0 → v3.13.1 (osism/osism-kubernetes#159)
- cilium-cli v0.16.20 → v0.18.3 (osism/osism-kubernetes#157)
- community.general 10.5.0 → 10.7.0 (osism/osism-kubernetes#161, osism/osism-kubernetes#175)
- flux v2.4.0 → v2.5.1 (osism/osism-kubernetes#157)
- ghcr.io/astral-sh/uv 0.6.13 → 0.7.8 (osism/osism-kubernetes#154, osism/osism-kubernetes#162, osism/osism-kubernetes#163, osism/osism-kubernetes#165, osism/osism-kubernetes#166, osism/osism-kubernetes#168, osism/osism-kubernetes#172, osism/osism-kubernetes#174, osism/osism-kubernetes#176, osism/osism-kubernetes#177, osism/osism-kubernetes#178)
- keycloak chart 22.2.1 → 24.6.3 (includes keycloak 25.0.4 → 26.2.2, postgresql subchart 15.5.23 → 16.6.6) (osism/osism-kubernetes#167)
- kubectl 1.30.7 → 1.32.3 (osism/osism-kubernetes#157)
- kubernetes.core 5.2.0 → 5.3.0 (osism/osism-kubernetes#173)
- operator-sdk v1.38.0 → v1.39.2 (osism/osism-kubernetes#157)
- osism.commons 0.20250407.0 → 0.20250529.0 (osism/osism-kubernetes#180)
- rook-ceph 1.16.5 → 1.16.6 (osism/osism-kubernetes#159)
- yaook charts 0.20250127.0 → 0.20250512.1 (osism/osism-kubernetes#156, osism/osism-kubernetes#179)

## [v0.20250408.0] - 2025-04-08

### Added
- Initial project setup with README (osism/osism-kubernetes#b3756db)
- Apache 2.0 LICENSE file (osism/osism-kubernetes#4)
- Zuul CI configuration with hadolint and yamllint jobs (osism/osism-kubernetes#1)
- Renovate dependency management configuration (osism/osism-kubernetes#2)
- Containerfile and container image build pipeline (osism/osism-kubernetes#3)
- Ansible roles and playbooks structure with initial cloudnative_pg role (osism/osism-kubernetes#8)
- Ansible-lint job to CI pipeline (osism/osism-kubernetes#8)
- Ansible, Helm, and kubectl installation to the container image (osism/osism-kubernetes#14)
- Entrypoint script using dumb-init (osism/osism-kubernetes#15)
- Mitogen Ansible plugin (osism/osism-kubernetes#16)
- Run script for executing Ansible playbooks (osism/osism-kubernetes#19)
- Defaults and generics repositories to container build (osism/osism-kubernetes#20)
- Version rendering in motd file (osism/osism-kubernetes#21)
- Initial set of Helm charts including cloudnative-pg, pxc-operator, rook-ceph, rook-ceph-cluster, mariadb-operator, rabbitmq-cluster-operator, kube-prometheus-stack, and kubernetes-dashboard (osism/osism-kubernetes#5)
- Headlamp Helm chart (Kubernetes web UI dashboard) (osism/osism-kubernetes#23)
- First set of YAOOK charts (crds, infra-operator, keystone-operator, keystone-resources-operator) (osism/osism-kubernetes#26)
- Script to render playbooks.yml file listing all available playbooks (osism/osism-kubernetes#29)
- `change.sh` script for replacing packages during development (osism/osism-kubernetes#30)
- Ansible directories (action_plugins, cache, logs, secrets) in container build (osism/osism-kubernetes#31)
- Volume declarations for `/share` and `/interface` in container (osism/osism-kubernetes#29)
- Symlink to `/etc/openstack` in container build (osism/osism-kubernetes#29)
- clusterctl installation in container (osism/osism-kubernetes#33)
- Playbooks for headlamp and kubernetes-dashboard deployments (osism/osism-kubernetes#34)
- secrets.sh script for Docker secrets support (NETBOX_TOKEN) (osism/osism-kubernetes#35)
- Ansible collections installation in container build (osism/osism-kubernetes#37)
- Missing ansible collections (ansible.utils, ansible.posix, community.general, osism.commons) and python3 alternatives (osism/osism-kubernetes#38)
- keycloak-operator role (osism/osism-kubernetes#40)
- Rendering of empty versions.yml file (osism/osism-kubernetes#41)
- netaddr Python package as dependency (osism/osism-kubernetes#42)
- operator-sdk installation in container build (osism/osism-kubernetes#44)
- Play to install the Operator Lifecycle Manager (OLM) (osism/osism-kubernetes#45)
- MariaDB operator and RabbitMQ operator roles with playbooks, tasks, and templates (osism/osism-kubernetes#46)
- Helm-diff plugin installation in container build (osism/osism-kubernetes#48)
- Zuul ansible-collection-ensure-readme job (osism/osism-kubernetes#51)
- Zuul flake8 and python-black jobs (osism/osism-kubernetes#52)
- Keycloak Helm chart (osism/osism-kubernetes#53)
- Cilium CLI installation in container image (osism/osism-kubernetes#54)
- prometheus-pushgateway Helm chart (osism/osism-kubernetes#55)
- Node-feature-discovery Helm chart for detecting hardware features on Kubernetes nodes (osism/osism-kubernetes#56)
- Memcached Helm chart, playbook, and role (osism/osism-kubernetes#59)
- Node Feature Discovery role and playbook (osism/osism-kubernetes#60)
- Headlamp role (osism/osism-kubernetes#61)
- Argo CD Helm chart (osism/osism-kubernetes#67)
- cert-manager Helm chart (osism/osism-kubernetes#69)
- SBOM generation and push to Dependency-Track in CI pipeline (osism/osism-kubernetes#72)
- Yaook cds-operator and horizon-operator charts (osism/osism-kubernetes#76)
- Yaook CRDs playbook and role for deploying yaook-crds Helm chart (osism/osism-kubernetes#78)
- Yaook operators playbook and role for deploying keystone-operator and keystone-resources-operator Helm charts (osism/osism-kubernetes#79)
- Prometheus Operator CRDs Helm chart (osism/osism-kubernetes#80)
- Playbook for labeling Kubernetes nodes with Yaook labels (osism/osism-kubernetes#81)
- cert-manager role and playbook (osism/osism-kubernetes#82)
- cert-manager-crds chart (osism/osism-kubernetes#83)
- Yaook cinder and glance operator Helm charts (osism/osism-kubernetes#84)
- Ingress-nginx play and role (osism/osism-kubernetes#85)
- Yaook CDS and infra operators (osism/osism-kubernetes#87)
- Missing ansible-vault.py script (osism/osism-kubernetes#93)
- teleport-cluster and teleport-kube-agent Helm charts (osism/osism-kubernetes#102)
- mariadb-operator-crds Helm chart (osism/osism-kubernetes#109)
- Flux CLI (osism/osism-kubernetes#133)
- Rook roles and playbooks for managing Ceph storage on Kubernetes (osism/osism-kubernetes#135)
- k3s roles and playbooks for cluster deployment, upgrade, and purge (osism/osism-kubernetes#139)
- Patch mechanism for applying patches to imported roles during container build (osism/osism-kubernetes#139)
- Kubernetes playbooks for kubeconfig management, node labeling, and orchestration (osism/osism-kubernetes#140)
- Cluster API playbook for CAPI management cluster initialization and upgrade (osism/osism-kubernetes#141)
- kubectl role and playbook with Debian and RedHat support (osism/osism-kubernetes#142)
- k9s role and playbook with Debian and RedHat support (osism/osism-kubernetes#143)

### Changed
- Zuul playbooks moved from `playbooks/` to `zuul-playbooks/` to separate CI from Ansible playbooks (osism/osism-kubernetes#8)
- Renovate configured to ignore the `charts/` directory (osism/osism-kubernetes#13)
- CI pipeline to support image pushing via Zuul (osism/osism-kubernetes#17)
- Sync Helm charts with upstream and add artifacthub.io links to chart references (osism/osism-kubernetes#22)
- Set default VERSION build argument to "latest" in Containerfile (osism/osism-kubernetes#24)
- Update Docker credentials in Zuul CI configuration (osism/osism-kubernetes#25, osism/osism-kubernetes#27)
- Entrypoint script now syncs playbooks, versions, and overlays to interface directories (osism/osism-kubernetes#32)
- Playbooks refactored to use `kubernetes.core.helm` module with configurable host targeting (osism/osism-kubernetes#34)
- Renamed `cloudnative_pg.yml` playbook to `kubernetes-cloudnative_pg.yml` to follow naming convention (osism/osism-kubernetes#29)
- Suppress Python UserWarnings to eliminate CryptographyDeprecationWarning in container (osism/osism-kubernetes#50)
- Operator SDK version extracted to a variable in Containerfile (osism/osism-kubernetes#54)
- Set KUBECONFIG environment variable in container image (osism/osism-kubernetes#57)
- Make cloudnative-pg role configurable with defaults for chart reference, release name, namespace, and Helm values (osism/osism-kubernetes#58)
- Headlamp: use kube-system namespace (osism/osism-kubernetes#64)
- Move CAPI_VERSION and KUBECTL_VERSION definitions to top of Containerfile (osism/osism-kubernetes#68)
- Make Helm state (cache and local directories) available to dragon user (osism/osism-kubernetes#71)
- Add `k8s` prefix to all Kubernetes playbook names (osism/osism-kubernetes#75)
- Improved Helm deployment task names to be more descriptive across multiple roles (osism/osism-kubernetes#82)
- Default namespace for ingress-nginx changed to `ingress-nginx` (osism/osism-kubernetes#86)
- CRD imports can now be individually enabled or disabled (osism/osism-kubernetes#90)
- Update Yaook operator charts to 0.20240919.2 (osism/osism-kubernetes#96)
- Enable cert-manager CRDs by default (osism/osism-kubernetes#105)
- Rework mariadb-operator role to use simplified Helm deployment with consolidated task structure (osism/osism-kubernetes#106)
- Use Python 3.13 base image instead of 3.12 (osism/osism-kubernetes#110)
- Update Yaook charts to 0.20241205.2, adding Designate CRD and ingress/status permissions for cinder-operator (osism/osism-kubernetes#115)
- Use dtrack.osism.tech as Dependency-Track server URL (osism/osism-kubernetes#126)
- Switch from pip to uv for Python package management (osism/osism-kubernetes#134)
- Cleaned up ansible-lint configuration by removing unnecessary default rules, custom rulesdir, and warn list (osism/osism-kubernetes#136)
- Update default Ceph image from v18.2.4 (Reef) to v19.2.1 (Squid) (osism/osism-kubernetes#137)
- Replace hardcoded `rook-ceph` namespace with `{{ $root.Release.Namespace }}` in CSI secret references (osism/osism-kubernetes#137)
- Add `serviceAccountName`, `revisionHistoryLimit`, configurable `pathType` for ingress, and various new CRD fields in rook-ceph-cluster chart (osism/osism-kubernetes#137)
- Add `revisionHistoryLimit`, `enforceHostNetwork`, `customHostnameLabel`, `operatorPodLabels`, and new CSI addon port settings in rook-ceph operator chart (osism/osism-kubernetes#137)
- Tighten RBAC permissions for volumesnapshots and volumesnapshotcontents by removing unnecessary `create` verb (osism/osism-kubernetes#137)
- Only checkout specific tags when not building latest (osism/osism-kubernetes#149)
- Decouple the image build from the old OSISM X.Y.Z release scheme (osism/osism-kubernetes#152)

### Fixed
- Docker login credentials in Zuul CI configuration (osism/osism-kubernetes#18)
- Dockerfile `FROM ... as` changed to `FROM ... AS` to fix FromAsCasing lint warning (osism/osism-kubernetes#28)
- Duplicate header comments removed from render-playbooks.py (osism/osism-kubernetes#32)
- Play location in run.sh script (osism/osism-kubernetes#36)
- Headlamp release namespace changed to kube-system (osism/osism-kubernetes#39)
- keycloak-operator role playbook naming, template directory default, and manifest application (osism/osism-kubernetes#43)
- Typo in kubernetes-dashboard chart reference path (`/chars/` → `/charts/`) (osism/osism-kubernetes#47)
- Fix node_feature_discovery and headlamp variable naming and defaults (osism/osism-kubernetes#62)
- Fix memcached variable naming, add kubeconfig path, and set default Helm values (osism/osism-kubernetes#63)
- Add missing `python_venv_dir` variable to Zuul build playbook (osism/osism-kubernetes#73)
- Fix wrong path to the inventory directory in run.sh (osism/osism-kubernetes#116)
- Fix rook Helm chart refs to use local chart paths instead of remote repository references (osism/osism-kubernetes#138)
- Fix wrong version in Containerfile (osism/osism-kubernetes#153)

### Removed
- Unused keycloak_operator config.yml referencing rook-ceph operator (osism/osism-kubernetes#58)
- Heat CRD from Yaook charts (osism/osism-kubernetes#96)
- YAKE repository from container build, will be provided via its own container image (osism/osism-kubernetes#121)

### Dependencies
- pxc-operator 1.14.1 → 1.15.0 (osism/osism-kubernetes#22, osism/osism-kubernetes#77)
- rook-ceph 1.14.6 → 1.16.5 (osism/osism-kubernetes#22, osism/osism-kubernetes#77, osism/osism-kubernetes#137)
- rook-ceph-cluster 1.14.5 → 1.16.5 (osism/osism-kubernetes#77, osism/osism-kubernetes#137)
- rabbitmq-cluster-operator 4.3.6 → 4.4.6 (osism/osism-kubernetes#22, osism/osism-kubernetes#77, osism/osism-kubernetes#146)
- kube-prometheus-stack 60.2.0 → 62.3.1 (osism/osism-kubernetes#22, osism/osism-kubernetes#77)
- kube-state-metrics 5.20.0 → 5.21.0 (osism/osism-kubernetes#22)
- prometheus-node-exporter 4.36.0 → 4.37.0 (osism/osism-kubernetes#22)
- grafana 8.0.2 → 8.3.1 (osism/osism-kubernetes#22)
- prometheus-operator v0.74.0 → v0.75.0 (osism/osism-kubernetes#22)
- controller-gen v0.14.0 → v0.15.0 (osism/osism-kubernetes#22)
- kubectl 1.29.1 → 1.30.7 (osism/osism-kubernetes#33, osism/osism-kubernetes#88, osism/osism-kubernetes#112)
- community.general 9.1.0 → 10.5.0 (osism/osism-kubernetes#49, osism/osism-kubernetes#70, osism/osism-kubernetes#91, osism/osism-kubernetes#97, osism/osism-kubernetes#103, osism/osism-kubernetes#104, osism/osism-kubernetes#111, osism/osism-kubernetes#119, osism/osism-kubernetes#123, osism/osism-kubernetes#127, osism/osism-kubernetes#128, osism/osism-kubernetes#132)
- ansible.utils 5.0.0 → 5.1.2 (osism/osism-kubernetes#65, osism/osism-kubernetes#89, osism/osism-kubernetes#94)
- pyyaml 6.0.1 → 6.0.2 (osism/osism-kubernetes#66)
- cilium-cli v0.16.13 → v0.16.20 (osism/osism-kubernetes#68, osism/osism-kubernetes#88, osism/osism-kubernetes#112)
- clusterctl (CAPI) 1.7.3 → 1.8.5 (osism/osism-kubernetes#68, osism/osism-kubernetes#88, osism/osism-kubernetes#112)
- cert-manager 1.15.2 → 1.15.3 (osism/osism-kubernetes#77)
- argo-cd 7.4.1 → 7.5.0 (osism/osism-kubernetes#77)
- memcached 7.4.11 → 7.4.12 (osism/osism-kubernetes#77)
- node-feature-discovery 0.15.4 → 0.16.4 (osism/osism-kubernetes#77)
- keycloak 21.8.0 → 22.2.1 (osism/osism-kubernetes#77)
- cloudnative-pg 0.21.5 → 0.22.0 (osism/osism-kubernetes#77)
- mariadb-operator 0.29.0 → 0.36.0 (osism/osism-kubernetes#77, osism/osism-kubernetes#107)
- headlamp 0.23.0 → 0.24.0 (osism/osism-kubernetes#77)
- mitogen 0.3.7 → 0.3.22 (osism/osism-kubernetes#74, osism/osism-kubernetes#100, osism/osism-kubernetes#108, osism/osism-kubernetes#125, osism/osism-kubernetes#131)
- ansible.posix 1.5.4 → 2.0.0 (osism/osism-kubernetes#92, osism/osism-kubernetes#98, osism/osism-kubernetes#101, osism/osism-kubernetes#113)
- operator-sdk v1.35.0 → v1.38.0 (osism/osism-kubernetes#88, osism/osism-kubernetes#112)
- yaook charts 0.20240704.1 → 0.20250127.0 (osism/osism-kubernetes#76, osism/osism-kubernetes#96, osism/osism-kubernetes#107, osism/osism-kubernetes#115, osism/osism-kubernetes#124)
- teleport-cluster 16.4.6 → 17.0.2 (osism/osism-kubernetes#114)
- teleport-kube-agent 16.4.6 → 17.0.2 (osism/osism-kubernetes#114)
- yake v1.103.0-1 → v1.108.0-0 (osism/osism-kubernetes#112)
- pip 24.0 → 24.3.1 (osism/osism-kubernetes#112)
- jinja2 3.1.4 → 3.1.6 [security] (osism/osism-kubernetes#118, osism/osism-kubernetes#130)
- kubernetes.core 5.0.0 → 5.2.0 (osism/osism-kubernetes#122, osism/osism-kubernetes#147)
- ingress-nginx 4.11.2 → 4.12.1 (osism/osism-kubernetes#144)
- osism.commons 0.20240702.0 → 0.20250407.0 (osism/osism-kubernetes#151)
- ghcr.io/astral-sh/uv 0.6.10 → 0.6.13 (osism/osism-kubernetes#145, osism/osism-kubernetes#148, osism/osism-kubernetes#150)

