#!/bin/sh
sudo apt update
sudo apt install -y openjdk-8-jdk awscli
aws s3 cp s3://demo-bucket/ /home/ubuntu --recursive
java -jar /home/ubuntu/demo-0.0.1-SNAPSHOT.jar
