#!/bin/bash

apt-get update
apt install docker.io -y
apt-get install -y docker-compose

#have to relogin as ubuntu user
sudo usermod -aG docker ubuntu
# restart new session with group
#newgrp docker

#let docker run when server is restarted
systemctl enable docker

#build the jenkins container
docker-compose up -d --build
