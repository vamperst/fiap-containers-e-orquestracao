## Swarm 2.1 - Montando seu cluster


1. Entre na pasta das demos da disciplina com o comando `cd ~/environment/fiap-containers-e-orquestracao/` e atualize o repositório com o comando `git reset --hard && git pull origin master`
2. Primeiramente você irá precisar entrar na pasta onde está o código responsável por criar o nó master do cluster. Para isso execute o comando `cd ~/environment/fiap-containers-e-orquestracao/02-Swarm/01-Montando-o-cluster/manager/`
3. Antes de iniciar , você precisa adicionar ao cloud9 a chave SSH a ser utilizada para criar as maquinas na AWS. Para isso volte na aba do seu navegador `Worksbench - Vocareum`, a mesma que utiliza para abrir a conta da AWS quando fica verde, e clique em `AWS Details` no canto superior direito.
   ![](img/5.png)
4. Em <b>SSH Key</b> clique em `Show` para visualizar a chave SSH que você irá utilizar para criar as maquinas na AWS.
   
   ![](img/6.png)

   ![](img/7.png)
5. Copie todo o conteúdo da chave SSH e volte para a aba do cloud9.
6. De volta ao cloud9, execute o comando `c9 open /home/ubuntu/.ssh/vockey.pem`. Esse comando vai abrir uma nova aba no seu IDE.
7. Cole o conteudo da chave SSH que você copiou anteriormente e salve o arquivo utilizando ctrl + S.
   
   ![](img/8.png)
8. No terminal execute o comando `chmod 400 ~/.ssh/vockey.pem` para dar as permissões corretas para a chave SSH.
9.  O seu cloud9 será seu nó master do cluster. Para isso execute a lista de comandos abaixo:
``` shell
publicIp=`curl http://169.254.169.254/latest/meta-data/public-ipv4`

docker swarm init --advertise-addr $publicIp
token=`docker swarm join-token worker -q`
tokenManager=`docker swarm join-token manager -q`

aws configure set default.region us-east-1
aws ssm put-parameter --name "docker-join-worker-token" --value $token --type "String" || aws ssm put-parameter --name "docker-join-worker-token" --value $token --type "String" --overwrite
aws ssm put-parameter --name "docker-join-manager-token" --value $tokenManager --type "String" || aws ssm put-parameter --name "docker-join-manager-token" --value $tokenManager --type "String" --overwrite
aws ssm put-parameter --name "docker-join-manager-ip" --value $publicIp --type "String" || aws ssm put-parameter --name "docker-join-manager-ip" --value $publicIp --type "String" --overwrite
```
10. Com o nó master de pé agora é hora de provisionar o worker para isso entre na pasta com o comando `cd ~/environment/fiap-containers-e-orquestracao/02-Swarm/01-Montando-o-cluster/workers/`.
11. Execute o comando `terraform init` para inicializar o terraform dos workers.
   ![](img/3.png)
12. Para provisionar o nó worker do cluster swarm utilize o comando `terraform apply --auto-approve`. Esse comando pode demorar por volta de 5 minutos para terminar.
   ![](img/4.png)
13. Ao final se executar o comando `docker node ls` verá os 2 nós no cluster.
   
   ![](img/10.png)
