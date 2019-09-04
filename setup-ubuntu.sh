#!/bin/bash
echo "Installing git and docker"
apt-get update && apt-get install \
	curl \
	git 
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu
