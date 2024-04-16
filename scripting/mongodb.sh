#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 SUCCESS$N"
    else
        echo -e "$R $2 FAILED $N"
        exit 1
    fi
}

cp /home/centos/vshell/scripting/mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Copiing repo"


yum install mongodb-org -y
VALIDATE $? "installing mongodb-org "


systemctl enable mongod
VALIDATE $? "enable mongod"


systemctl start mongod
VALIDATE $? "starting mongod "

sed 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "replacing with 0.0.0.0 "

systemctl restart mongod
VALIDATE $? "restarted mongod "