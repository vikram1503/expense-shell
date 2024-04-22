#!/bin/bash
userid=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
scriptname=$( echo $0 | cut -d "." -f1 )
logfile=/tmp/$scriptname-$timestamp.log
r="\e[31m"
g="\e[32m"
y="\e[33m"
n="\e[0m"

validate(){
    if [ $1 -ne 0 ]
    then echo -e "$2...$r failure $n"
    exit 1
    else echo -e "$2...$g success $n"
    fi
}

if [ $userid -ne 0 ]
then 
echo "you are not super user get root access"
exit 1
else 
echo "you are super user"
fi

dnf module disable nodejs -y &>>$logfile
validate $? "disabling default nodejs"

dnf module enable nodejs:20 -y &>>$logfile
validate $? "enabling nodejs:20 version"


dnf install nodejs -y &>>$logfile
validate $? "installing nodejs"


