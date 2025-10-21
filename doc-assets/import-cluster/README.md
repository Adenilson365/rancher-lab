### Importar Cluster criado externamente

### Cloud

- Crie a credential

  ![Menu Cluster Management no Rancher com a opção para adicionar Cloud Credential.](image.png)

- Selecione a credential e o Cluster, se a credential possuir permissão suficiente o Rancher fará o import.
  ![Formulário de credencial GCP no Rancher com Project ID, Name, Region, seleção de cluster para importação.](image-1.png)
- Criara os agents no cattle-system, assim que os pods do agent ficarem running o cluster passa a ser gerenciado pelo Rancher.
  ![Lista de pods dos agentes do Rancher no namespace cattle-system após a importação.](image-2.png)

- Sempre que há uma troca de nó, o cluster perde temporáriamente a conexão com upstream, mesmo que o pod do agent não esteja nesse nó.
  ![Lista de nós do cluster gerenciado exibida no Rancher](image-3.png)

- deletar o cluster importado via UI

![Cluster em estado ‘Waiting’ para remoção no Rancher, aguardando limpeza dos recursos](image-4.png)

- Vai remover o cluster da gestão do Rancher e limpar os objetos instalados no cluster, incluindo namespaces.
- Precisa validar oque acontece se durante esse processo o cluster perder conexão.
  - Retoma a limpeza ao retornar conexão?
  - È necessário limpar na mão oque restar?
    > Esse processo não deleta o cluster, apenas limpa os objetos criados pelo Rancher.
    >
    > > Cluster criados no rancher são deletados nesse processo.
