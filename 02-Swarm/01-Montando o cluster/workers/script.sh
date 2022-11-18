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

aws configure set default.region us-east-1
token=`aws ssm get-parameter --name "docker-join-worker-token" | jq .Parameter.Value -r`
publicIp=`aws ssm get-parameter --name "docker-join-manager-ip" | jq .Parameter.Value -r`

docker swarm join --token  $token $publicIp:2377

accountID=`aws sts get-caller-identity | jq .Account -r`
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $accountID.dkr.ecr.us-east-1.amazonaws.com