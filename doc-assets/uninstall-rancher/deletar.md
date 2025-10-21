## Uninstall no Helm

- Cluster criado pelo Rancher

![Mostra tela cluster management com lista de clusters gerenciados com status active.](prd-cluster-ui.png)

- Rodando comando uninstall no helm:

![Lista de releases instaladas pelo helm chart do rancher. são eles: Rancher, rancher-gke-operator, rancher-gke-operator, rancher-webhook](uninstall.png)

- Removeu os recursos mas ficou um deploy para tras

![Lista de charts helm que ficaram pendentes, após comando helm uninstall, sendo: rancher-gke-operator-crd](image.png)

- No Downstream não removeu os agents, ao desinstalar não executou ações no downstream

![Listagem de pods no namespace cattle-system](image-1.png)

- Ao reinstalar o Rancher no Upstream os clusters Downstream voltaram a ser gerenciáveis sem precisar de intervenção.

![Mostra tela cluster management com lista de clusters gerenciados com status active](image-2.png)
