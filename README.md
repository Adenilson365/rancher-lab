## Rancher - Gerenciamento multi-cluster

[Repositório IAC GCP](https://github.com/Adenilson365/devopslabs01-iac)

### Instalar no GKE

[Preparação do cluster ](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/install-upgrade-on-a-kubernetes-cluster/rancher-on-gke)

[Instalar Rancher via Helm](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/install-upgrade-on-a-kubernetes-cluster#install-the-rancher-helm-chart)

[Cert-manager](https://artifacthub.io/packages/helm/cert-manager/cert-manager)

- Revisar certificados

  [TLS](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/installation-references/tls-settings#agent-tls-enforcement)

- Há 3 modos de TLS
  - strict - Usa o TLS gerado pelo cluster e precisa ter cert-manager
  - system-store
  - false
- O default é strict
- Para alterar acesse o cluster local e edit o setting, default altere para system-store

```shell
kubectl edit setting agent-tls-mode -o yaml
```

### Versão rancher vs k8s

```txt
Error: INSTALLATION FAILED: chart requires kubeVersion: < 1.33.0-0 which is incompatible with Kubernetes v1.33.2-gke.1240000
```

### Instalação

### Criar Cluster com Ec2

[Documentação](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/launch-kubernetes-with-rancher/use-new-nodes-in-an-infra-provider/create-an-amazon-ec2-cluster)

-
