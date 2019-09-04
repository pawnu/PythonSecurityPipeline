#!/bin/bash
echo "Installing curl and docker"
apt-get update
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt-get install -y docker-compose
mkdir ~/jenkins_home
chown 1000 ~/jenkins_home
usermod -aG docker ubuntu
echo "Please reboot the Ubuntu server"
