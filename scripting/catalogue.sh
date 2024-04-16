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

dnf module disable nodejs -y
VALIDATE $? "disable nodejs"

dnf module enable nodejs:18 -y
VALIDATE $? "enabling nodejs"

dnf install nodejs -y
VALIDATE $? "installing nodejs"

if [ id roboshop -ne 0 ]
then
    useradd roboshop
else    
    echo -e "$Y user roboshop is already exist $N"
fi


if [ -d "/app" ]; 
then
  echo -e "$Y app directory laready exist. $N"
else
    mkdir /app
    echo -e "$G app directory created $N"
fi

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

systemctl daemon-reload
VALIDATE $? "daemon-reload"

systemctl enable catalogue
VALIDATE $? "enabling catalogue"

systemctl start catalogue
VALIDATE $? "starting catalogue"

cp /home/centos/vshell/scripting/mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "dcopying mongo.repo"

dnf install mongodb-org-shell -y
VALIDATE $? "installing mongodb-org-shell"

mongo --host 172.31.30.115 </app/schema/catalogue.js
VALIDATE $? "conneting mongodb"
