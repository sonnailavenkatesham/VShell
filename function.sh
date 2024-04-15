#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 success $N ..done"
    else
        echo -e "$R $2 failded $N "
    fi
}

yum install gitt -y
VALIDATE $? "git"