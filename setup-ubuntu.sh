#!/bin/bash

apt-get update
apt install docker.io -y
apt-get install -y docker-compose
mkdir ~/jenkins_home
# give same level of ownership for local and remote mount file
chown 1000 ~/jenkins_home
usermod -aG docker ubuntu

#let docker run when server is restarted
systemctl start docker
systemctl enable docker

echo "Rebooting the Ubuntu server"
sleep 5s
systemctl reboot
