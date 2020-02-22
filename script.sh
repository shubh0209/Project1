#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
sudo mkdir -p /nginx
echo "Hello World!!!, I am nginx server serving static content, running using docker on ec2 instance managed by terraform and build using jenkins, deployed in CICD pipe
line triggered by GIT push to master branch demostrated to Durgesh." > index.html

sudo docker run -d -p 80:80 -v /nginx/:/usr/share/nginx/html/ --name nginx nginx