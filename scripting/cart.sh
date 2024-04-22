c#!/bin/bash

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

curl -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>> $path
VALIDATE $? "downloded artifact"

cd /app &>> $path
VALIDATE $? "changing to app directory"

unzip /tmp/cart.zip &>> $path
VALIDATE $? "unzipping artifact"

npm install
VALIDATE $? "npm installing"


cp /home/centos/vshell/scripting/cart.service /etc/systemd/system/cart.service &>> $path
VALIDATE $? "copying cart.service"

systemctl daemon-reload &>> $path
VALIDATE $? "daemon-reload"

systemctl enable cart &>> $path
VALIDATE $? "enabling cart"

systemctl start cart &>> $path
VALIDATE $? "starting cart"
