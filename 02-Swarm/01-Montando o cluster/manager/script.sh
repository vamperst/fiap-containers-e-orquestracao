#!/bin/bash

# install nginx
sudo yum update -y
sudo amazon-linux-extras list | grep nginx
sudo yum clean metadata -y

sudo amazon-linux-extras install docker -y
sudo service docker start

sudo usermod -a -G docker ec2-user
docker info

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo yum install jq -y

publicIp=`curl http://169.254.169.254/latest/meta-data/public-ipv4`

docker swarm init --advertise-addr $publicIp

token=`docker swarm join-token worker -q`
tokenManager=`docker swarm join-token manager -q`

aws configure set default.region us-east-1
aws ssm put-parameter --name "docker-join-worker-token" --value $token --type "String" || aws ssm put-parameter --name "docker-join-worker-token" --value $token --type "String" --overwrite
aws ssm put-parameter --name "docker-join-manager-token" --value $tokenManager --type "String" || aws ssm put-parameter --name "docker-join-manager-token" --value $tokenManager --type "String" --overwrite
aws ssm put-parameter --name "docker-join-manager-ip" --value $publicIp --type "String" || aws ssm put-parameter --name "docker-join-manager-ip" --value $publicIp --type "String" --overwrite

accountID=`aws sts get-caller-identity | jq .Account -r`
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $accountID.dkr.ecr.us-east-1.amazonaws.com