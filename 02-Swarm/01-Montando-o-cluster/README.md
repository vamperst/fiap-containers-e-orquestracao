## Swarm 2.1 - Montando seu cluster


1. Entre na pasta das demos da disciplina com o comando `cd ~/environment/fiap-containers-e-orquestracao/` e atualize o repositório com o comando `git reset --hard && git pull origin master`
2. Primeiramente você irá precisar entrar na pasta onde está o código responsável por criar o nó master do cluster. Para isso execute o comando `cd ~/environment/fiap-containers-e-orquestracao/02-Swarm/01-Montando-o-cluster/manager/`
3. A aplicação que irá provisionar o cluster se chama [terraform](https://www.terraform.io/) e para inicializar ela execute o comando `terraform init`
   ![](img/1.png)
4. Agora para provisionar o nó master execute o comando `terraform apply --auto-approve`. Esse comando pode demorar por volta de 5 minutos para terminar.
![](img/2.png)
5. Com o nó master de pé agora é hora de provisionar o worker para isso entre na pasta com o comando `cd ~/environment/fiap-containers-e-orquestracao/02-Swarm/01-Montando-o-cluster/workers/`.
6. Execute o comando `terraform init` para inicializar o terraform dos workers.
   ![](img/3.png)
7. Para provisionar o nó worker do cluster swarm utilize o comando `terraform apply --auto-approve`. Esse comando pode demorar por volta de 5 minutos para terminar.
   ![](img/4.png)
