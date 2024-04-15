#!/bin/bash

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo " $1 success  $2"
    else
        echo "$2"
    fi
}

echo "Hello Rakesh"
VALIDATE $? "Hello"