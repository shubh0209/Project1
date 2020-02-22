#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
sudo mkdir -p /nginx

sudo docker run -d -p 80:80 -v /nginx/:/usr/share/nginx/html/ --name nginx nginx