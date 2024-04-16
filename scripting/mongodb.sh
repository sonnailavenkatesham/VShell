#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"



cp /home/centos/vshell/scripting/mongo.repo /etc/yum.repos.d/mongo.repo

if [ $? -eq 0 ]
then
    echo -e "$G SUCCESS$N"
else
    echo -e "$R FAILED $N"
    exit 1
fi

yum install mongodb-org -y
if [ $? -eq 0 ]
then
    echo -e "$G SUCCESS$N"
else
    echo -e "$R FAILED $N"
    exit 1
fi

systemctl enable mongod
if [ $? -eq 0 ]
then
    echo -e "$G SUCCESS$N"
else
    echo -e "$R FAILED $N"
    exit 1
fi

systemctl start mongod
if [ $? -eq 0 ]
then
    echo -e "$G SUCCESS$N"
else
    echo -e "$R FAILED $N"
    exit 1
fi

sed 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
if [ $? -eq 0 ]
then
    echo -e "$G SUCCESS$N"
else
    echo -e "$R FAILED $N"
    exit 1
fi

systemctl restart mongod
if [ $? -eq 0 ]
then
    echo -e "$G SUCCESS$N"
else
    echo -e "$R FAILED $N"
    exit 1
fi