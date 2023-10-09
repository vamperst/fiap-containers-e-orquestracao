# 00 - Setup e Configuração de ambiente

Você irá utilizar 2 ferramentas para desenvolver os laboratorios:
1. Conta AWS através da AWS Academy. Conta provisionada para você utilizar durante essa disciplina com 100 dólares de crédito.
2. Cloud 9 IDE. Uma IDE cloud dentro da AWS para todos terem um ambeinte igual e com a autorização para executar os comandos dos exercicios.

### Conta AWS - Academy

1. Caso não tenha conta no AWS Academy ainda:
   1. Entre no seu email da FIAP pelo endereço [webmail.fiap.com.br](http://webmail.fiap.com.br/)
   2. Seu email é no seguinte formato rm + numero do seu RM + @fiap.com.br. Caso seu RM seja por exemplo 12345 seu email seria rm12345@fiap.com.br. A senha é a mesma de portais.
   3. Você terá um email na caixa de entrada para convite do Academy, siga as instruções.
   4. Ao conseguir entrar na plataforma do academy, aparecerá uma turma que começa com `AWS Academy Learner Lab`. Apenas clique em `Enroll` para aceitar e acessar.
2. Para entrar na conta do Academy que já existe, acesse o link:  [awsacademy.com/LMS_Login](https://www.awsacademy.com/LMS_Login). Ao conseguir entrar na plataforma do academy, aparecerá uma turma que começa com AWS Academy Learner Lab. Apenas clique em Enroll para aceitar e acessar.
3. Dentro da plataforma clique em `cursos` na lateral esquerda e clique no curso da disciplina atual.
![](img/academy1.png)
4. Dentro do curso clique em `Módulos` na lateral esquerda
   
   ![](img/academy2.png)

5. Clique em `Iniciar os laboratórios de aprendizagem da AWS Academy`
   
   ![](img/academy3.png)

6. Se for seu primeiro acesso irão aparecer os 2 contratos de termos e condições para aceitar. Role até o final para aceitar após a leitura do mesmo. Caso já tenha feito isso antes. Pule para o passo 8.
   ![](img/academy4.png)
7. Clique no link iniciando com `Academy-CUR` para acessar a conta AWS.Caso peça consentimento clique em `I agree` e execute o passo novamente.
   ![](img/academy8.png)
8. Essa é a tela para acessar sua conta AWS. Cada sessão terá 4 horas. Após esse tempo você terá que começar outra sessão, mas os dados gravados dentro da conta AWS ficam salvos até o final do curso ou entrega do trabalho final da disciplina. Clique em `Start Lab` para iniciar uma sessão. Esse processo pode demorar alguns minutos.
   ![](img/academy5.png)
   ![](img/academy6.png)
9.  Quando tudo estiver pronto a bolinha ao lado do escrito `AWS` no superior esquerdo da tela ficará verde como na imagem abaixo. Apenas clique em `AWS` para abrir a conta aws em outra aba do navegador.
![](img/academy7.png)

### Cloud 9
 1. Abra o console da AWS e va para o serviço `Cloud 9` através da barra de pesquisas.
   ![img/acharcloud9.png](img/acharcloud9.png)
1. garanta que a região que esta utilizando é `us-east-1/ Norte da Virgínia`. Você consegue ver isso no canto superior direiro da tela.
    ![img/regiao.png](img/regiao.png)
2. Clique em `create environment`.
3. Coloque o nome `lab-fiap` .
   ![img/nomelab.png](img/nomelab.png)
4. Deixe as configurações como na imagem a seguir. Se atente ao tipo da maquina que deve ser `t2.medium` e o sistema operacional `Ubuntu Server 22.04 LTS`:
   ![img/config.png](img/config.png)
5. Em `Configurações de rede` deixe como na imagem a seguir:
  ![img/configuracaoDeRede.png](img/configuracaoDeRede.png)
6. Caso todos os passos anteriores estejam corretos, clique em `Criar`.
7. A criação do ambiente pode levar alguns minutos.
![img/criando.png](img/criando.png)
 1. Após a criação clique em `Em aberto`, caso o IDE não tenha aberto automaticamente.
   ![img/abriride.png](img/abriride.png)
2. Para os próximos comandos utilize o console bash que fica no canto inferior do seu IDE.
   ![img/bash.png](img/bash.png)
3.  Execute o comando `npm install -g serverless` para instalar o serverless framework.
    ![img/installserverless.png](img/installserverless.png)
4.   Execute o comando `sudo apt update -y && sudo apt  install jq -y` para instalar o software que irá nos ajudar a ler e manipular Jsons no terminal. Caso esse comando de erro, aguarde 3 minutos para o sistema terminar a preparação inicial.
5.  Execute o comando `npm install -g c9` para baixar a extenção que ajudará o Cloud9 a lidar melhor com o como abrir arquivos no IDE.
6.  Execute o comando `git clone https://github.com/vamperst/fiap-containers-e-orquestracao.git` para clonar o repositório com os exercicios.
7.  Execute o comando `cd fiap-containers-e-orquestracao/` para entrar na pasta criada pelo git
8.  Execute o comando `cd 00-Setup-e-configuracao` para entrar na pasta com os scripts de Configuração.
9.  Precisamos aumentar o tamanho do volume(HD) do cloud9. Para isso execute o comando  `sh resize.sh`
   ![img/resizeEBS](img/resizeEBS.png)
10. Execute o comando `sh installDocker.sh` para instalar o docker.
