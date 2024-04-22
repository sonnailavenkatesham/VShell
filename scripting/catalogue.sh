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

dnf module disable nodejs -y &>> $path
VALIDATE $? "disable nodejs"

dnf module enable nodejs:18 -y &>> $path
VALIDATE $? "enabling nodejs"

dnf install nodejs -y &>> $path
VALIDATE $? "installing nodejs"

useradd roboshop

mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip  
VALIDATE $? "downloded artifact"

cd /app 
VALIDATE $? "changing to app directory"

unzip /tmp/catalogue.zip 
VALIDATE $? "unzipping artifact"

npm install 
VALIDATE $? "npm installing"


cp /home/centos/vshell/scripting/catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "copying catalogue.service"

systemctl daemon-reload &>> $path
VALIDATE $? "daemon-reload"

systemctl enable catalogue &>> $path
VALIDATE $? "enabling catalogue"

systemctl start catalogue &>> $path
VALIDATE $? "starting catalogue"

cp /home/centos/vshell/scripting/mongo.repo /etc/yum.repos.d/mongo.repo &>> $path
VALIDATE $? "dcopying mongo.repo"

dnf install mongodb-org-shell -y &>> $path
VALIDATE $? "installing mongodb-org-shell"

mongo --host mongodb.venkateshamsonnalia143.online </app/schema/catalogue.js &>> $path
VALIDATE $? "conneting mongodb"
