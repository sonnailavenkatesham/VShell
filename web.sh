#!/bin/bash

sudo yum install nginx -y

sudo systemctl enable nginx

sudo systemctl start nginx

sudo rm -rf /usr/share/nginx/html/*

sudo curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip

 cd /usr/share/nginx/html/
echo "Changed to html folder"
sudo unzip /tmp/web.zip
echo "unzipping"

sudo systemctl restart nginx 