# Hands-On Kubernetes

Bem-vindos ao laboratório de hands-on de Kubernetes! Durante esta atividade, você irá aprender como criar um cluster Kubernetes utilizando o Elastic Kubernetes Service (EKS) e entender os principais componentes que formam um cluster Kubernetes.

Vamos abordar como criar o deploy de aplicação e quais são componentes necessários, além de escalar o ambiente, verificar os logs dos contêineres e acessar um Pod via SSH.

Ao final deste laboratório, você passará a entender os principais componentes do kubernetes, apto a criar e gerenciar seus próprios clusters Kubernetes na AWS, utilizando as melhores práticas para orquestração de contêineres. Vamos começar!


## O que é o EKS

O Amazon Elastic Kubernetes Service (EKS) é um serviço gerenciado de Kubernetes que simplifica o processo de implantação, operação e manutenção de clusters Kubernetes na Amazon Web Services (AWS).

O EKS fornece um ambiente Kubernetes totalmente gerenciado, que inclui:

Nós do Kubernetes gerenciados pela AWS
Controle de acesso e gerenciamento de identidade
Atualizações e patches do Kubernetes
Monitoramento e alertas
O EKS é uma boa opção para organizações que desejam implantar e gerenciar aplicativos Kubernetes na AWS sem precisar gerenciar a infraestrutura subjacente.

Aqui estão alguns dos benefícios do EKS:

Fácil de configurar e gerenciar: O EKS fornece um ambiente Kubernetes totalmente gerenciado, o que significa que você não precisa se preocupar com a instalação ou manutenção da infraestrutura subjacente.
Segurança: O EKS fornece recursos de segurança integrados, como controle de acesso e gerenciamento de identidade.
Escalabilidade: O EKS é escalável horizontalmente para atender às suas necessidades.
Compatibilidade: O EKS é compatível com o Kubernetes, o que significa que você pode usar as ferramentas e plugins de sua escolha.

Mas existem outras opções de clusters Kubernetes gerenciados em outras clouds publicas, como: Google: Google Kubernetes Engine (GKE) e Azure: Azure Kubernetes Service (AKS).

### Pré-requisitos:
Ter acesso a conta lab no AWS Academy https://awsacademy.instructure.com/.


## Provisionando o EKS

1. Acesse o console da aws e pesquise por EKS e clique em Elastic Kubernetes Service.\

![nginx](img/1.png)

2. Ao clicar na página do serviço clique em <b>Add cluster</b>.\

![nginx](img/2.png)

Depois clique em create.\

![nginx](img/3.png)

3. Ao clicar em create vamos preencher o nome do nosso cluster como `eks-lab` em <b>Nome</b>.\

![nginx](img/4.png)

4. Logo em seguida clique em Next.\

![nginx](img/5.png)

5. Em <b>Subnets</b> selecione as subnets `us-east-1a`, `us-east-1b` e `us-east-1c` e em <b>Security Groups</b> selecione o security group `default`.\

![nginx](img/6.png)

6. Clique em Next:\

![nginx](img/7.png)

7. Nas configurações de log, em <b>Control plane logging</b> habilite os logs do `API Server`, `Audit`, `Authenticator`, `Controller Manager` e `Scheduler` e depois clique em <b>Next</b>.\

![nginx](img/8.png)

8. Em <b>add-ons</b> deixe selecionado o `CoreDNS`, `Amazon VPC CNI` e `kube-proxy`, logo em seguida clique em <b>Next</b>.\

![nginx](img/9.png)

9. Clique em <b>Next</b>.\

![nginx](img/10.png)

10. Clique em <b>Next</b> novamente para confirmar a instalação das versões dos plugins.\

![nginx](img/11.png)

11. Aguarde a criação do cluster, demora em torno de 10 minutos.\

![nginx](img/11.1.png)

![nginx](img/11.2.png)

### Cloud Shell

Para gerenciar o nosso cluster, iremos utilizar o Cloud Shell serviço de Terminal Interativo da AWS.

Antes vamos entender o que é o Cloud Shell!

O AWS Cloud Shell é um ambiente de terminal interativo baseado no navegador que permite que você execute comandos e scripts da AWS CLI. Ele é pré-provisionado com as ferramentas e bibliotecas mais comuns que você precisa para trabalhar com a AWS, incluindo:

- Bash: O shell padrão do Linux
- Python: Uma linguagem de programação popular
- Node.js: Um ambiente de execução JavaScript
- Git: Um sistema de controle de versão

12. No concole da AWS, no canto inferior esquerdo, tem o ícone do Cloud Shell, clique nele!\
![nginx](img/cd01.png)

13. Ao clicar no ícone do CloudShell ele irá provisionar um console para você poder utilizar para gerenciar os serviços da aws através de CLI (Command Line Interface).\
![nginx](img/cd02.png)

> O CloudShell é como se fosse aqueles consoles que existe em data centers, para quem não conhece:
![nginx](img/cd03.png)

Agora que conhece o CloudShell e para que ele serve, iremos utilizar ele até o final desta aula.

Nosso cluster já foi provisionado e agora precisamos gerenciar ele, lembra que eu comentei sobre o API Server que o cliente (kubectl) se conecta a ele para poder gerenciar o cluster.

### Conhecendo o kubectl

O kubectl é uma ferramenta de linha de comando utilizada para interagir com clusters Kubernetes. Ele permite que os usuários gerenciem aplicativos e recursos em um cluster Kubernetes, como implantações, serviços, pods, configurações, etc.

Com o kubectl, é possível implantar e escalar aplicativos, fazer rolling updates e rollbacks, gerenciar o estado dos pods e serviços, criar e gerenciar objetos personalizados, além de muitas outras tarefas relacionadas ao gerenciamento de um cluster Kubernetes.

O kubectl é uma ferramenta essencial para qualquer pessoa que trabalhe com Kubernetes, como desenvolvedores, administradores de sistemas e operadores de cluster. Ele é usado em um ambiente de terminal para interagir com o cluster Kubernetes e executar operações em qualquer nó ou componente do cluster.

Em resumo, o kubectl é a principal ferramenta de gerenciamento de Kubernetes que permite que você controle e gerencie aplicativos em um cluster Kubernetes.

O <b>CloudShell</b> já vem com o `kubectl` então não precise se preoupar com a instalação, mas caso precise instalar, acesse a documentação: [clique aqui!](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)


### Configurando o Kubectl
14. Agora iremos configurar o kubectl, execute o comando abaixo no <b>CloudShell</b>:

``` shell
aws eks update-kubeconfig --region us-east-1 --name eks-lab
```

Verificando se os componentes do cluster está executando corretamente:

``` shell
kubectl cluster-info
```

```shell
OUTPUT
Kubernetes control plane is running at https://6FE18A9AFD90A9493632AEB363346F9E.gr7.us-east-1.eks.amazonaws.com
CoreDNS is running at https://6FE18A9AFD90A9493632AEB363346F9E.gr7.us-east-1.eks.amazonaws.com/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

```

15. Verificando se o Etcd, Scheduler e o Controller-Manager está funcionando corretamente.

``` shell
kubectl get componentstatuses
```

```shell
OUTPUT:
NAME                 STATUS    MESSAGE   ERROR
etcd-0               Healthy   ok
controller-manager   Healthy   ok
scheduler            Healthy   ok
```

16. Listando os nós do cluster:

``` shell
kubectl get nodes
```

```shell
OUTPUT:
No resources found
```

O que está faltando provisionar?

### Provisionando os Nodes Groups

17. Faltou provisionarmos o nosso <b>Node Group</b>, para provisionar, em [cluster EKS](https://us-east-1.console.aws.amazon.com/eks/home?region=us-east-1#/clusters/eks-lab) clique em <b>Compute</b> e logo na sequência clique em <b>Add node group</b>.\
![nginx](img/12.png)

18. Adiciono o nome `eks-lab-node-group` e selecione o IAM role `LabRole` e clique em <b>Next</b>.\

![](img/12.1.png)

19. Na pagina seguinte apenas clique em <b>Next</b>.

![](img/12.2.png)

20. Na pagina seguinte apenas clique em <b>Next</b>.

![](img/12.3.png)

21. Revise as informações e clique em <b>Create</b>.

22. Listando os componentes do cluster

``` shell
kubectl get all --all-namespaces
```

```shell
OUTPUT:

NAMESPACE     NAME                          READY   STATUS    RESTARTS   AGE
kube-system   pod/aws-node-h4457            2/2     Running   0          174m
kube-system   pod/aws-node-qhdgm            2/2     Running   0          171m
kube-system   pod/coredns-58488c5db-6lbn2   1/1     Running   0          171m
kube-system   pod/coredns-58488c5db-v89qz   1/1     Running   0          172m
kube-system   pod/kube-proxy-x7sqh          1/1     Running   0          171m
kube-system   pod/kube-proxy-zwgdr          1/1     Running   0          174m

NAMESPACE     NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)         AGE
default       service/kubernetes   ClusterIP   10.100.0.1    <none>        443/TCP         9h
kube-system   service/kube-dns     ClusterIP   10.100.0.10   <none>        53/UDP,53/TCP   9h

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   daemonset.apps/aws-node     2         2         2       2            2           <none>          9h
kube-system   daemonset.apps/kube-proxy   2         2         2       2            2           <none>          9h

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/coredns   2/2     2            2           9h

NAMESPACE     NAME                                DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/coredns-58488c5db   2         2         2       9h
```

23. Listando os contextos dos clusters configurados:

``` shell
kubectl config get-contexts
```

```shell
OUTPUT:
CURRENT   NAME                                                 CLUSTER                                              AUTHINFO                                             NAMESPACE
          arn:aws:eks:us-east-1:679551794714:cluster/abc       arn:aws:eks:us-east-1:679551794714:cluster/abc       arn:aws:eks:us-east-1:679551794714:cluster/abc
*         arn:aws:eks:us-east-1:679551794714:cluster/eks-lab   arn:aws:eks:us-east-1:679551794714:cluster/eks-lab   arn:aws:eks:us-east-1:679551794714:cluster/eks-lab
```

O kubectl pode ser usado para configurar o contexto de um cluster no arquivo ~/.kube/config. Esse arquivo é usado pelo kubectl para determinar qual cluster, usuário e namespace devem ser usados para interagir com o cluster.

A seguir estão os principais elementos de um contexto configurado no arquivo ~/.kube/config:

`apiVersion`: a versão da API do Kubernetes usada pelo arquivo de configuração.\
`kind`: o tipo do objeto Kubernetes. Para um contexto, o tipo é Context.\
`name`: o nome do contexto.\
`context`: um objeto que define as informações de contexto para um cluster, incluindo cluster, user e namespace.\
`cluster`: um objeto que define as informações do cluster, incluindo o nome do cluster e o endpoint para se conectar ao API server.\
`user`: um objeto que define as informações de autenticação do usuário, como o nome do usuário e a chave de acesso.\
`namespace`: o namespace padrão a ser usado pelo contexto.\

Um exemplo de contexto configurado no arquivo ~/.kube/config pode ser semelhante a este:

```
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJWkxsMFErVjNVRGN3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TXpFeE1ERXdNRE...kwySmsyd2hKUUppUHRNQ1piUlNKS3hDM2tzWkEKUkV3VExGZG5nR1owCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://SUASUGSHSUAYRSKDKSAUSA.gr7.us-east-1.eks.amazonaws.com
  name: arn:aws:eks:us-east-1:679551794714:cluster/eks-lab
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJZGg4TWlYc2xiUEV3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TXpFeE1ERXdOVEkwTWpCYUZ3MHp...RU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://SUASUGSHSUAYRSKDKSAUSA.gr7.us-east-1.eks.amazonaws.com
  name: arn:aws:eks:us-east-1:679551794714:cluster/abc
contexts:
- context:
    cluster: arn:aws:eks:us-east-1:679551794714:cluster/eks-lab
    user: arn:aws:eks:us-east-1:679551794714:cluster/eks-lab
  name: arn:aws:eks:us-east-1:679551794714:cluster/eks-lab
```

### Realizando o deploy de uma aplicação

Agora que já entendemos os principais componentes do Cluster, iremos realizar o deploy de uma app, essa app será basicamente uma imagem do NGINX,  O NGINX é um servidor web de código aberto que pode ser usado para servir arquivos estáticos ou atuar como um proxy reverso para outros servidores web.


Na path /manifests, tem os manifestos para realizarmos o deploy.

Antes iremos preparar o ambiente criando um namespace (isolamento lógico) `nginx` para podermos realizar o deploy da nossa app.

`manifests/01-namespace.yaml`

```
---
kind: Namespace
apiVersion: v1
metadata:
  name: nginx
  labels:
    name: nginx
```

24. Para criar execute os comandos:

```
cd ~/
git clone https://github.com/vamperst/fiap-containers-e-orquestracao.git
cd ~/fiap-containers-e-orquestracao/03-kubernetes/02-cluster-eks
kubectl apply -f manifests/00-namespace.yaml
```

25. Após a criação do namespace, iremos executar o comando para listar todos os namespaces.

``` shell
kubectl get namespace
```

```shell
OUTPUT:
NAME              STATUS   AGE
default           Active   10h
kube-node-lease   Active   10h
kube-public       Active   10h
kube-system       Active   10h
```

Após ter criado o namespace iremos realizar o nosso primeiro o `01-deployment.yaml`, vamos entender os principais componentes deste manifesto.

`manifests/01-deployment.yaml`

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 100%
      maxUnavailable: 25%
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        command: ["/bin/bash"]
        args: ["-c", "echo '<h1>This is the new Kubernetes default page!</h1>' > /usr/share/nginx/html/index.html && exec nginx -g 'daemon off;'"]
        restartPolicy: OnFailure
        ports:
        - containerPort: 80
        resources:
          limits:
            cpu: "100m"
            memory: "256Mi"
          requests:
            cpu: "50m"
            memory: "128Mi"

```

`apiVersion:` especifica a versão da API que está sendo utilizada, neste caso a apps/v1.\
`kind:` especifica o tipo de objeto que está sendo criado, neste caso um Deployment.\
`metadata:` contém informações de metadados do objeto, como o nome e labels para identificação.\
`replicas:` especifica o número de réplicas que serão criadas para garantir a disponibilidade da aplicação.\
`selector:` especifica o seletor de labels que será usado para identificar os Pods que fazem parte do Deployment.\
`template:` especifica o modelo para criação dos Pods do Deployment.\
`metadata:` contém as informações de metadados do Pod.\
`labels:` especifica as labels para identificação do Pod.\
`spec:` especifica as características do Pod, como os containers que serão executados dentro dele.\
`containers:` especifica o(s) container(s) que serão executados no Pod.\
`name:` especifica o nome do container.\
`image:` especifica a imagem do container que será utilizada.\
`ports:` especifica as portas que serão expostas pelo container. Neste caso, a porta 80 foi exposta.\

26. Após entender cada item do nosso manifesto, vamos utilizar ele para realizar o deploy do nosso app.


``` shell
kubectl create -f manifests/01-deployment.yaml
```

```shell
OUTPUT:
deployment.apps/nginx created
```

27. Após aplicado, iremos listar a nossa app. Repare que os pods já estão em status de Running.

``` shell
kubectl get pods -n nginx
NAME                     READY   STATUS    RESTARTS   AGE
nginx-57787bb6df-2sgx7   1/1     Running   0          37s
nginx-57787bb6df-k27wr   1/1     Running   0          37s
nginx-57787bb6df-lvrp4   1/1     Running   0          37s
```

28. Trazendo informação mais detalhada dos pods.

``` shell
kubectl get pods -n nginx -o wide
```

```shell
OUTPUT:
NAME                     READY   STATUS    RESTARTS   AGE    IP              NODE                            NOMINATED NODE   READINESS GATES
nginx-57787bb6df-2sgx7   1/1     Running   0          2m1s   172.31.6.187    ip-172-31-12-186.ec2.internal   <none>           <none>
nginx-57787bb6df-k27wr   1/1     Running   0          2m1s   172.31.3.92     ip-172-31-12-186.ec2.internal   <none>           <none>
nginx-57787bb6df-lvrp4   1/1     Running   0          2m1s   172.31.89.245   ip-172-31-93-147.ec2.internal   <none>           <none>
```

29. Conhecendo o POD da nossa app, com o comando `kubectl describe pods <pod-name>`

``` shell
kubectl describe pods nginx-57787bb6df-2sgx7 -n nginx
```

```shell
OUTPUT:
Name:             nginx-57787bb6df-2sgx7
Namespace:        nginx
Priority:         0
Service Account:  default
Node:             ip-172-31-12-186.ec2.internal/172.31.12.186
Start Time:       Wed, 01 Nov 2023 10:34:57 +0000
Labels:           app=nginx
                  pod-template-hash=57787bb6df
Annotations:      <none>
Status:           Running
IP:               172.31.6.187
IPs:
  IP:           172.31.6.187
Controlled By:  ReplicaSet/nginx-57787bb6df
Containers:
  nginx:
    Container ID:  containerd://c35a0fa58303cdb880aa93533a72eedfed286f468cceb71e7e4d4cc3338caa4a
    Image:         nginx:latest
    Image ID:      docker.io/library/nginx@sha256:775b948ed18e931cfe48c4664387162764dcf286303bbe02bd72703f72f17f02
    Port:          80/TCP
    Host Port:     0/TCP
    Command:
      /bin/bash
    Args:
      -c
      echo '<h1>Hello K8s World</h1>' > /usr/share/nginx/html/index.html && exec nginx -g 'daemon off;'
    State:          Running
      Started:      Wed, 01 Nov 2023 10:35:06 +0000
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     100m
      memory:  256Mi
    Requests:
      cpu:        50m
      memory:     128Mi
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-lxp86 (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  kube-api-access-lxp86:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  3m27s  default-scheduler  Successfully assigned nginx/nginx-57787bb6df-2sgx7 to ip-172-31-12-186.ec2.internal
  Normal  Pulling    3m23s  kubelet            Pulling image "nginx:latest"
  Normal  Pulled     3m19s  kubelet            Successfully pulled image "nginx:latest" in 4.843s (4.843s including waiting)
  Normal  Created    3m19s  kubelet            Created container nginx
  Normal  Started    3m18s  kubelet            Started container nginx
```

30. Conhecendo o nosso deploy, utilizando o comando `kubectl describe deploy <deploy-name>`, mas antes iremos pegar o nome do nosso deploy\
Primeiro vamos realizar o `kubectl get deploy` para listar todos os deploys de todos os namespaces.


``` shell
kubectl get deploy nginx -n nginx
```

```shell
OUTPUT:
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   3/3     3            3           115m
```

31. Descrevendo o deploy `nginx`.

``` shell
kubectl describe deploy nginx -n nginx
```

```shell
OUTPUT:
Name:                   nginx
Namespace:              nginx
CreationTimestamp:      Wed, 01 Nov 2023 10:34:57 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 100% max surge
Pod Template:
  Labels:  app=nginx
  Containers:
   nginx:
    Image:      nginx:latest
    Port:       80/TCP
    Host Port:  0/TCP
    Command:
      /bin/bash
    Args:
      -c
      echo '<h1>Hello K8s World</h1>' > /usr/share/nginx/html/index.html && exec nginx -g 'daemon off;'
    Limits:
      cpu:     100m
      memory:  256Mi
    Requests:
      cpu:        50m
      memory:     128Mi
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-57787bb6df (3/3 replicas created)
Events:          <none>
```

### Acessando a App

Para acessar a app, precisamos expor o serviço em nosso cluster apontando para os nossos pods.

Criando a service para poder acessar a app, o manifesto está na path `manifests/02-service-nginx.yaml`.\
O conteúdo do manifesto é:

`manifests/02-service-nginx.yaml`


```
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
  namespace: nginx
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
````

Este manifesto descreve um serviço do Kubernetes com as seguintes configurações:

`apiVersion:` a versão da API do Kubernetes usada para criar o recurso. Neste caso, é a versão "v1".\
`kind:` o tipo do recurso Kubernetes que está sendo criado. Neste caso, é um "Service".\
`metadata:` informações sobre o objeto sendo criado, incluindo um nome descritivo e rótulos que permitem que o recurso seja pesquisado e gerenciado com facilidade.\
`spec:` as especificações do serviço, incluindo sua configuração de rede e informações de porta.\
`selector:` uma seleção baseada em rótulos que identifica os pods a serem expostos pelo serviço. Neste caso, o serviço expõe todos os pods com o rótulo "app: nginx".\
`type:` o tipo de serviço a ser criado. Neste caso, é um LoadBalancer, que permite fazer o balanceamento de carga entre os ips dos nós\
`ports:` as portas expostas pelo serviço. Neste caso, uma única porta é exposta com o nome "http" e mapeada para a porta 80 nos pods correspondentes à seleção de rótulo do serviço.


32. Após entender cada item do nosso manifesto, vamos utilizar ele para realizar o deploy da nossa service.

``` shell
kubectl apply -f manifests/02-service-nginx.yaml
```

```shell
OUTPUT:
service/nginx-service created
```

33. Acessado a nossa "app" via Load Balancer.

``` shell
kubectl get service -n nginx
```

```shell
OUTPUT:
NAME    TYPE           CLUSTER-IP     EXTERNAL-IP                                                              PORT(S)        AGE
nginx   LoadBalancer   10.100.84.30   a0d10f8234df541fc807413cb72fe8dc-844940680.us-east-1.elb.amazonaws.com   80:32469/TCP   14s
```

Repare que a nossa service `nginx` foi criada com sucesso.

34. Agora vamos acessar o app através do navegador, digite a url do Load Balancer:

```
http://a0d10f8234df541fc807413cb72fe8dc-844940680.us-east-1.elb.amazonaws.com/
```
![nginx](img/service-01.png)

Sucesso! conseguimos acessar a nossa app.

### Escalando os PODs

35. Para escalar os pods iremos executar o comando `kubectl scale deployment`, atualmente temos 2 répicas e iremos aumentar para 8 réplicas.

``` shell
kubectl scale deployment nginx --replicas=8 -n nginx
```

```shell
OUTPUT:
deployment.apps/nginx scaled
```

36. Checando se foi escalado corretamente.

``` shell
kubectl get pods -n nginx
```

```shell
OUTPUT:
NAME                     READY   STATUS              RESTARTS   AGE
nginx-57787bb6df-2sgx7   1/1     Running             0          128m
nginx-57787bb6df-dk7wt   0/1     ContainerCreating   0          3s
nginx-57787bb6df-k27wr   1/1     Running             0          128m
nginx-57787bb6df-lvrp4   1/1     Running             0          128m
nginx-57787bb6df-m5kch   0/1     ContainerCreating   0          3s
nginx-57787bb6df-r2sgf   0/1     ContainerCreating   0          3s
nginx-57787bb6df-r4qzq   0/1     ContainerCreating   0          3s
nginx-57787bb6df-sn64c   0/1     ContainerCreating   0          3s
```

37. Repare que os containers foram escalados para 8 réplicas.

``` shell
kubectl get pods -n nginx
```

```shell
OUTPUT:
NAME                     READY   STATUS    RESTARTS   AGE
nginx-57787bb6df-2sgx7   1/1     Running   0          3h29m
nginx-57787bb6df-dk7wt   1/1     Running   0          80m
nginx-57787bb6df-k27wr   1/1     Running   0          3h29m
nginx-57787bb6df-lvrp4   1/1     Running   0          3h29m
nginx-57787bb6df-m5kch   1/1     Running   0          80m
nginx-57787bb6df-r2sgf   1/1     Running   0          80m
nginx-57787bb6df-r4qzq   1/1     Running   0          80m
nginx-57787bb6df-sn64c   1/1     Running   0          80m
```

Pronto os PODs foram escalados com sucesso!

38. Vamos voltar para duas réplicas.

``` shell
kubectl scale deployment nginx --replicas=2 -n nginx
```

```shell
OUTPUT:
deployment.apps/nginx scaled
```

### Realizando rollback de versão

39. Para realizar o rollback da versão iremos aplicar o manifesto `manifests/deployment-v1.yaml`

``` shell
kubectl apply -f manifests/03-deployment-v1.yaml
```

```shell
OUTPUT:
deployment.apps/nginx-deployment configured
```

40. Execute o curl para verificar se alterou a página do nosso webserver.

``` shell
curl http://http://a0d10f8234df541fc807413cb72fe8dc-844940680.us-east-1.elb.amazonaws.com/
```

```shell
OUTPUT:
<h1>Deploy V1!</h1>
```

Ou acesse pelo browser:\
![nginx](img/deploy-v1.png)

41. Após realizar o deploy, vamos realizar o deploy do `manifests/deployment-v2.yaml`

``` shell
kubectl apply -f manifests/04-deployment-v2.yaml
```

```shell
OUTPUT:
deployment.apps/nginx-deployment configured
```

42. Execute o curl para verificar se alterou a versão.

``` shell
# curl http://a0d10f8234df541fc807413cb72fe8dc-844940680.us-east-1.elb.amazonaws.com/
```

```shell
OUTPUT:
<h1>Deploy V2!</h1>
```
Ou acesse pelo browser:\
![nginx](img/deploy-v2.png)

43. Repare que os pods estão recém criados:
``` shell
kubectl get pods -l app=nginx -n nginx
```

```shell
OUTPUT:
NAME                    READY   STATUS    RESTARTS   AGE
nginx-5fd47c7f7-28h4z   1/1     Running   0          10s
nginx-5fd47c7f7-gg8qj   1/1     Running   0          10s
nginx-5fd47c7f7-mqfm5   1/1     Running   0          10s
```

44. Agora iremos realizar o Rollback para a versão 1 do nosso deployment. O Deployment cria uma revisão a cada alteração no deploy, para listar essas versões iremos utilizar o `kubectl rollout history`:

``` shell
kubectl rollout history deploy nginx -n nginx
```

```shell
OUTPUT:
deployment.apps/nginx-deployment
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         <none>
```

45. Agora vamos realizar o rollback para a versão 2 da nossa app.

``` shell
kubectl rollout undo deployment/nginx --to-revision=1 -n nginx
```

```shell
deployment.apps/nginx rolled back
```

46. Vamos checar se ele alterou para a versão que fizemos a nossa alteração:

    Realize o curl para verificar se estamos na Versão 2 da app, lembrando que na linha do tempo a versão 2 do histório de deploy, deve retornar a página com a frase <b>Deploy V1!</b>.

``` shell
curl http://a0d10f8234df541fc807413cb72fe8dc-844940680.us-east-1.elb.amazonaws.com/
```

```shell
OUTPUT:
<h1>Deploy V1!</h1>
```
Ou acesse pelo browser:\
![nginx](img/deploy-v1.png)

Pronto, agora você acabou de aprender a fazer rollback para uma versão específica da sua app.


### Finalizando o Lab

Agora é hora de limpar a casa! :)

Vamos deletar os objetos que criamos dentro do nosso cluster Kubernetes

47. Deletando a Service:

``` shell
kubectl delete -f 02-service-nginx.yaml
```

```shell
OUTPUT:
service "nginx" deleted
```

48. Deletendo o Deployment:

``` shell
kubectl delete -f 01-deployment.yaml
```

```shell
OUTPUT:
deployment.apps "nginx" delete
```

Excluindo o <b>Node Group</b> do Cluster EKS.

49. Acesse o serviço [EKS](https://us-east-1.console.aws.amazon.com/eks/home?region=us-east-1#/clusters)

![nginx](img/1.png)

50. Clique no cluster do lab `eks-lab`

![nginx](img/eks-destroy01.png)

51. Clique na aba <b>Compute</b>

![nginx](img/eks-destroy02.png)

52. Desça até <b>Node groups</b>, selecione o `lab-nodegroup` e clique em <b>Delete</b>

![nginx](img/eks-destroy03.png)

53. Por questão de segurança você precisa colocar o nome do node group para ter certeza que precisa deletar ele (isso evita a deleção acidental), depois clique em <b>Delete</b>!

![nginx](img/eks-destroy05.png)

54. Agora basta esperar alguns minutos para realizar a deleção\

![nginx](img/eks-destroy06.png)

55. Pronto, após a deleção do node group, iremos realizar a deletar o Cluster, no cluster clique em <b>Delete cluster</b>.

![nginx](img/eks-destroy07.png)

56. Para deletar coloque o nome do cluster <b>eks-lab</b> para confirmar a deleção, logo em seguida clique em <b>Delete</b>

![nginx](img/eks-destroy08.png)

57. Após confirmar a deleção, o cluster será deletado em alguns minutos.

![nginx](img/eks-destroy09.png)


### Conclusão
Parabéns, você concluiu com sucesso este laboratório de hands-on de Kubernetes!

Durante este laboratório, você aprendeu como criar um cluster Kubernetes usando o K3d e sobre os principais componentes que compõem um cluster Kubernetes. Você também aprendeu como criar um pod, deployment de uma aplicação, como escalar o ambiente, verificar os logs e até mesmo acessar um pod via SSH.

Este conhecimento é fundamental para quem deseja entender e trabalhar com Kubernetes, uma das plataformas mais utilizadas no mundo para orquestração de containers. Esperamos que este laboratório tenha sido útil para você e que agora você se sinta mais confiante para trabalhar com Kubernetes em seu ambiente. Parabéns novamente e continue praticando!