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

### Para usar PrivateCA:

[Configurar CA ](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/resources/add-tls-secrets)

- Além dos certificados tls é necessário fornecer a CA, para que o downstream consiga validar a conexão TLS
- Caso não forneça, nos pods rancher no upstream o erro abaixo:
  ![alt text](./doc-assets/erro-mount-vol-ca.png)

- Nesse lab foi usado certificado gerado pela Let's encrypt usando certbot
- Isso gera 4 arquivos: cert.pem chain.pem fullchain.pem privkey.pem
- O certificado TLS é gerado com fullchain.pem e a privkey.pem

```shell
kubectl create secret generic tls-rancher-ingress   --from-file=tls.crt=./fullchain.pem   --from-file=tls.key=./privkey.pem    -n cattle-system

```

- CA
- Crie uma cópia do chain.pem com nome cacerts.pem
- crie o secret que contém a ca

```shell
kubectl -n cattle-system create secret generic tls-ca --from-file=./chain.pem
```

- **Troubleshooting**
- Ao criar o cluster o erro:
  ![alt text](./doc-assets/erro-conditions.png)
- Pods para verificar logs
- Upstream: rancher pods no namespace cattle-system
- Downstream: agent pods no nampespace cattle-system
- Possível validar o cacerts na UI em: globalsettings>showcacerts
- Endpoint onde downstream consulta cacerts: https://<MeuDominio>/v3/settings/cacerts

- Calcular o checksum:

```shell
# Precisa ser igual ao no pod do agent no downstream
  sha256sum cacerts.pem
```

### Versão rancher vs k8s

```txt
Error: INSTALLATION FAILED: chart requires kubeVersion: < 1.33.0-0 which is incompatible with Kubernetes v1.33.2-gke.1240000
```

### Instalação

### Criar Cluster com Ec2

[Documentação](https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/launch-kubernetes-with-rancher/use-new-nodes-in-an-infra-provider/create-an-amazon-ec2-cluster)

-
