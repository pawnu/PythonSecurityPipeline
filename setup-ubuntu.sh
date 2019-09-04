#!/bin/bash
echo "Installing curl and docker"
apt-get update && apt-get install curl
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu
echo "Please reboot the Ubuntu server"
