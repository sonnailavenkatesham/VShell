#!/bin/bash
DATE=$(date +%x-%T)
echo $DATE
echo "Please enter name:"
read name
if [ $name -eq "venkat" ]
then
    echo "Welcome to Devops"
else
    echo "Please provide correct name"
    exit1
fi





