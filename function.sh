#!/bin/bash

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R $2....FAILED $N"
        exit 1
    else
        echo -e "$G $2....SUCCESSFULL $N"
    fi
}

echo "Hello Rakesh"
# VALIDATE $? "module disable nodejs"