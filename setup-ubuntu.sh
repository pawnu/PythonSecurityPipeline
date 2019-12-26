#!/bin/bash

apt-get update
apt install docker.io -y
apt-get install -y docker-compose
apt install default-jre -y

#have to relogin as ubuntu user
usermod -aG docker ubuntu

#let docker run when server is restarted
systemctl enable docker

#create random password for jenkins user which will be created automatically
export Jenkins_PW=$(openssl rand -base64 16)
export JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

#we're providing the server its public hostname for its relative links
export JenkinsPublicIp=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)

#build the jenkins container
docker-compose up -d --build

# restart new session with docker group
#newgrp docker

sleep 5
wget --no-proxy http://localhost:8080/jnlpJars/jenkins-cli.jar
sleep 5
java -jar ./jenkins-cli.jar -s http://localhost:8080 -auth myjenkins:$Jenkins_PW create-job pythonpipeline < config.xml

echo "------- Your temporary Jenkins login ---------"
echo "myjenkins"
echo $Jenkins_PW
