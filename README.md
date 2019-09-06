# Dockerfiles for Jenkins server

Use this project to create a Jenkins server to run SCA on JAVA or Python

*NOTE: This has been tested on Ubuntu 18.04 amd64 server*

## Installation steps

1. Clone this repository to your Ubuntu Server
```
git clone https://github.com/pawnu/JenkinsOnDocker.git
```
2. Run the setup script to install Docker and docker-compose
```
cd JenkinsOnDocker
sudo sh setup-ubuntu.sh
```
3. Restart the Ubuntu server to finish installation
4. Build the docker container in detatched mode and run it
```
cd JenkinsOnDocker
docker-compose up -d --build
```
5. Make sure your firewall allows incoming traffic to port 8080. Then, go to your jenkins server URL 
```
http://your-jenkins-server:8080/
```
6. Input the admin password from the docker logs generated, and create Jenkins user.
```
docker logs <your-jenkins-container-name>
```

7. Skip the plugin installation as this has been installed already.
