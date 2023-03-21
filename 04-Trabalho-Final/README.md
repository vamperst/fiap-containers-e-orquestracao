# Trabalho final Docker, Swarm and Registry

Para executar o trabalho crie uma pasta na raiz do cloud9. Para tal execute o comando `mkdir -p ~/environment/trabalho-final && cd ~/environment/trabalho-final`

1. Crie um Dockerfile que instale um NGINX utilizando um Ubuntu latest como base.
   1. Imagem a ser utilizada como base: [ubuntu:latest](https://hub.docker.com/_/ubuntu)
   2. Documentação de como instalar e rodar o nginx em ubuntu: [How To Install Nginx on Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-22-04)
2. Execute o build da sua imagem dando o nome de nginx-trabalho-final.
2. Crie um cluster swarm.
3. Crie um repositório do ECR e faça o push da imagem montada no passo 2.
4. Crie um docker-compose.yml que contenha:
   1. Um serviço chamado "web" que utiliza sua imagem do ECR, utilize a porta 80 do container e porta 5000 do nó e que apenas possa ser executado no nó manager.
   2. Criar uma network chamada "servico" do tipo overlay e attachable
5. Rode o docker compose criado no cluster swarm.


##### Entregavel

Monte um zip contendo:
1. Os arquivos Dockerfile e docker-compose criados
2. Prints do cluster swarm com o serviço executando `docker service ls`
3. Print do console do ECR onde foi feito o push da imagem

##### Material para consulta

1. Dockerfile: [link](https://github.com/vamperst/fiap-containers-e-orquestracao/tree/master/01-containers/02-Dockerfile)
2. ECR: [link](https://github.com/vamperst/fiap-containers-e-orquestracao/tree/master/01-containers/03-registry)
3. Criar cluster swarm: [link](https://github.com/vamperst/fiap-containers-e-orquestracao/tree/master/02-Swarm/01-Montando-o-cluster)
4. Docker-compose e execução: [link](https://github.com/vamperst/fiap-containers-e-orquestracao/tree/master/02-Swarm/02-compose-%26-swarm-intro)


