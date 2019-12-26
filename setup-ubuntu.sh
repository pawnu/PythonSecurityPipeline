#!/bin/bash

apt-get update
apt install docker.io -y
apt-get install -y docker-compose

#have to relogin as ubuntu user
usermod -aG docker ubuntu
# restart new session with group
#newgrp docker

#let docker run when server is restarted
systemctl enable docker

#create random password for jenkins user which will be created automatically
export Jenkins_PW=$(openssl rand -base64 16)

#build the jenkins container
docker-compose up -d --build

#Create the jenkins job
apt install default-jre -y
curl 'localhost:8080/jnlpJars/jenkins-cli.jar' > jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080 -auth myjenkins:$Jenkins_PW create-job pythonpipeline < config.xml
