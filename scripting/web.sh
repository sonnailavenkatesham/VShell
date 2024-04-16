#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
path=/tmp/mongodb.logs

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 SUCCESS$N"
    else
        echo -e "$R $2 FAILED $N"
        exit 1
    fi
}

dnf install nginx -y
VALIDATE $? "installing Nginx"

systemctl enable nginx
VALIDATE $? "enabling nginx"

systemctl start nginx
VALIDATE $? "starting  nginx"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "removing default html files"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip
VALIDATE $? "downloading web artifact"

cd /usr/share/nginx/html
VALIDATE $? "changing  to html folder"

unzip /tmp/web.zip
VALIDATE $? "Unzipping web artifact"

cp /home/centos/vshell/scripting/roboshop.conf /etc/nginx/default.d/roboshop.conf 
VALIDATE $? "copying roboshop.conf"


systemctl restart nginx 
VALIDATE $? "restarting nginx"
