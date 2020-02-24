#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
sudo mkdir -p /nginx
cd /nginx
sudo bash -c "echo 'Hello World, I am nginx server which serves static content, running using docker on ec2 instance managed by terraform and build using jenkins, deployed in CICD pipe
line, triggered by a GIT push to master branch.' > index.html"

sudo docker run -d -p 80:80 -v /nginx/:/usr/share/nginx/html/ --name nginx nginx
sudo docker run -d -p 8080:8080 shubh228/simple-nodejs:v1