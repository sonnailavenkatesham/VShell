#!/bin/bash

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "success"
    else
        echo "Failed"
    fi
}

echo "Hello Rakesh"
VALIDATE $?