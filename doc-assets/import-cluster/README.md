### Importar Cluster criado externamente

### Cloud

- Crie a credential

  ![alt text](image.png)

- Selecione a credential e o Cluster, se a credential possuir permissão suficiente o Rancher fará o import.
  ![alt text](image-1.png)
- Criara os agents no cattle-system, assim que os pods do agent ficarem running o cluster passa a ser gerenciado pelo Rancher.
  ![alt text](image-2.png)

- Sempre que há uma troca de nó, o cluster perde temporáriamente a conexão com upstream, mesmo que o pod do agent não esteja nesse nó.
  ![alt text](image-3.png)

- deletar o cluster importado via UI
  ![alt text](image-4.png)

- Vai remover o cluster da gestão do Rancher e limpar os objetos instalados no cluster, incluindo namespaces.
- Precisa validar oque acontece se durante esse processo o cluster perder conexão.
  - Retoma a limpeza ao retornar conexão?
  - È necessário limpar na mão oque restar?
