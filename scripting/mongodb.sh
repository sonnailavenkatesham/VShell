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

cp /home/centos/vshell/scripting/mongo.repo /etc/yum.repos.d/mongo.repo &>> $path
VALIDATE $? "Copiing repo" 


yum install mongodb-org -y &>> $path
VALIDATE $? "installing mongodb-org "


systemctl enable mongod &>> $path
VALIDATE $? "enable mongod"


systemctl start mongod &>> $path
VALIDATE $? "starting mongod "

sed 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>> $path
VALIDATE $? "replacing with 0.0.0.0 "

systemctl restart mongod &>> $path
VALIDATE $? "restarted mongod "