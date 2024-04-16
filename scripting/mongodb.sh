#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"



cp /home/centos/vshell/scriptin/gmongo.repo /etc/yum.repos.d/mongo.repo

if [ $? -eq 0 ]
then
    echo -e "$G SUCCESS$N"
else
    echo -e "$R FAILED $N"
    exit 1
fi

yum install mongodb-org -y

systemctl enable mongod

systemctl start mongod

sed 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

systemctl restart mongod