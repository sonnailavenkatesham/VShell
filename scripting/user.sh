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

curl -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> $path
VALIDATE $? "downloded artifact"

cd /app &>> $path
VALIDATE $? "changing to app directory"

unzip /tmp/user.zip &>> $path
VALIDATE $? "unzipping artifact"

npm install
VALIDATE $? "npm installing"


cp /home/centos/vshell/scripting/user.service /etc/systemd/system/user.service &>> $path
VALIDATE $? "copying user.service"

systemctl daemon-reload &>> $path
VALIDATE $? "daemon-reload"

systemctl enable user &>> $path
VALIDATE $? "enabling user"

systemctl start user &>> $path
VALIDATE $? "starting user"

cp /home/centos/vshell/scripting/mongo.repo /etc/yum.repos.d/mongo.repo &>> $path
VALIDATE $? "dcopying mongo.repo"

dnf install mongodb-org-shell -y &>> $path
VALIDATE $? "installing mongodb-org-shell"

mongo --host mongodb.venkateshamsonnalia143.online </app/schema/user.js &>> $path
VALIDATE $? "conneting mongodb"
