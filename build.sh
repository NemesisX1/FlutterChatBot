#!/bin/bash

echo "Building and commiting the web app Epitech Chatbot"

flutter pub get;
rm -rf docs;
flutter build web;
mv build/web docs;