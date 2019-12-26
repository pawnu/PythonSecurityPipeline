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
export JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

#we're providing the server its public ip for its relative links
export JenkinsPublicIp=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

#build the jenkins container
docker-compose up -d --build

#Create the jenkins job
apt install default-jre -y
sleep 5
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
sleep 5
java -jar ./jenkins-cli.jar -s http://localhost:8080 -auth myjenkins:$Jenkins_PW create-job pythonpipeline < config.xml

echo "------- Your temporary Jenkins login ---------"
echo "myjenkins"
echo $Jenkins_PW
