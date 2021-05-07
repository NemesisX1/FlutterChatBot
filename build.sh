#!/bin/bash

if [[  "$#" -ne  2 ]]
then
  echo "./build.sh <commit> <branch>"
else
    echo "Building and commiting the web app Epitech Chatbot"
    flutter pub get 
    rm -rf docs
    flutter build web
    mv build/web docs
    git add --all
    git commit -m $1
    git push origin $2
fi