#!/bin/bash

sudo apt-get update
sudo apt install docker.io -y
sudo apt-get install -y docker-compose
sudo usermod -aG docker ubuntu
#restart group
sudo newgrp docker

#let docker run when server is restarted
systemctl start docker
systemctl enable docker

#build the jenkins container
docker-compose up -d --build
