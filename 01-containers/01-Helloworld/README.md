## Conteiners 1.1 - Helloworld

1. No terminal do Cloud9 récem criado digite `docker run hello-world`
   
![img/hello-world.png](img/hello-world.png)

2. Suba um container ubuntu em entre nele na maneira interativa com o comando `docker run -ti ubuntu bash`. A opções "-ti" são as responsáveis por após a criação do container fazer o acesso a ele através do terminal.

![img/ubuntubash.png](img/ubuntubash.png)

3. Para sair do modo interativo do container utilize o combinação de teclas `ctrl + P + Q`
4. Para verificar que o container que o container ainda esta ligado utilize o comando `docker ps`
![img/docker-ps.png](img/docker-ps.png)
5. Note que o nome do container foi escolhido de maneira aleatória, para que isso não aconteça utilize o comando `docker run -ti --name ubuntu-teste ubuntu bash`.
6.  Saia do container com `ctrl + P + Q`
7.  Outra maneira de ver os containers em execução é o comando  `docker container ls`

![img/container-ls.png](img/container-ls.png)

8. Utilize o comando `docker container ls -a` para ver todos os containers ativos e inativos do host

![img/containerls-a.png](img/containerls-a.png)

9. Utilize o comando `docker image ls` para ver todos as imagens do host

![img/dockerimagels.png](img/dockerimagels.png)

10. Agora que temos 2 containers iguais rodando, vamos parar e eliminar um deles com os seguintes comandos `docker container stop ubuntu-teste` e `docker container rm ubuntu-teste`

![img/dockerrm.png](img/dockerrm.png)

11. Agora com o comando `docker container ls -a` podemos ver que temos apenas 2 containers na maquina. Um ativo e um inativo.
12. Agora você vai forçar a remoção de um container em uso, para isso utilize o comando `docker container rm -f {nome do container ubuntu rodando}`. Para pegar o nome do container utilize o comando `docker container ls` e copie o nome do container que tem imagem ubuntu.

![img/dockerrm-f.png](img/dockerrm-f.png)

13.  Agora temos apenas um container no host `docker container ls -a`

![img/restaum/png](img/restaum/png)

14.  Delete o container que sobrou com o comando `docker container rm -f {nome do container restante}`.
15.  Delete a imagem do ubuntu do seu host com o comando `docker image rm {image_id}`, para conseguir o image_id rode o comando `docker image ls`

![img/imagerm.png](img/imagerm.png)

16. Execute o mesmo procedimendo para a imagem do hello-world

![img/hellormimagetry.png](img/hellormimagetry.png)

![img/hellorm.png](img/hellorm.png)

17.  Para limpar o restante do host execute o comando `docker system prune -a`

![img/systemprune.png](img/systemprune.png)
