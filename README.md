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

7. Continue with the setup to get to Jenkins main page

## Setting up a Jenkins Pipeline project
1. Click on New Item, input name for your project and select Pipeline as the option and click OK.
2. Scroll down to Pipeline section - Definition, select "Pipeline script from SCM" from drop down menu.
3. Select Git under SCM, and input Repository URL such as `https://github.com/pawnu/jenkinspythondemo.git`
4. Create and Add your credentials for the Git repo, and click Save.
5. You will be brought to the Dashboard of your Pipeline project, click on "Build Now" button to start off the pipeline.
