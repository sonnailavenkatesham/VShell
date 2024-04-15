#!/bin/bash
DATE=$(date +%x-%T)
echo $DATE
echo "Please enter your ID:"
read id
if [ $id -eq 0296 ]
then
    echo "Hi Rakesh, Welcome to Devops"
else
    echo "Please provide correct name"
    exit 1
fi





