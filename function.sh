#!/bin/bash

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo " $2 success"
    else
        echo "$2 failded"
    fi
}

yum install git -y
VALIDATE $? "git"