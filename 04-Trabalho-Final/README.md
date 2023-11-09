# Trabalho final Docker, Swarm and Registry

Para executar o trabalho crie uma pasta na raiz do cloud9. Para tal execute o comando `mkdir -p ~/environment/trabalho-final && cd ~/environment/trabalho-final`

1. Crie um Dockerfile que instale um NGINX utilizando um Ubuntu latest como base.
   *** <b>DEVIDO A UM ERRO ESTOU POSTANDO O CONTEÚDO DO ARQUIVO DOCKERFILE. É SÓ COPIAR E IR PARA O PASSO 2</b>***
   ``` Dockerfile
   FROM ubuntu:18.04
   RUN apt-get update -y && \
      apt-get install -y -q curl gnupg2
   RUN curl <http://nginx.org/keys/nginx_signing.key> | apt-key add -
   RUN apt-get update && \
      apt-get install -y -q nginx
   ADD nginx.conf /etc/nginx/
   ADD server.conf /etc/nginx/conf.d
   EXPOSE 443 80
   CMD ["nginx", "-g", "daemon off;"]
   ```
2. Execute o build da sua imagem dando o nome de nginx-trabalho-final.
3. Crie um cluster swarm.
4. Crie um repositório do ECR e faça o push da imagem montada no passo 2.
5. Crie um docker-compose.yml que contenha:
   1. Um serviço chamado "web" que utiliza sua imagem do ECR, utilize a porta 80 do container e porta 5000 do nó e que apenas possa ser executado no nó manager.
   2. Criar uma network chamada "servico" do tipo overlay e attachable
6. Rode o docker compose criado no cluster swarm.


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


