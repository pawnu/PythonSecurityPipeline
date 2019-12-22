# Dockerfiles for Jenkins server

Use this project to create a Jenkins server on AWS Ubuntu 18.04 and DevSecOps pipeline for Python web application

*Disclaimer: This project is for prototype, do not use it for deploying to production*

**TO DO:**
- [ ] Use ansible to create and deploy project to AWS ec2 instances
- [ ] Use cloudformation template to automate the environment configuration
- [ ] Use Jenkins API/config to setup and automatically create the pipeline job

## Environment configuration manual steps

1. Clone this repository to your Ubuntu Server
```
git clone https://github.com/pawnu/PythonSecurityPipeline.git
```
2. Run the setup script to install Docker and docker-compose
```
cd PythonSecurityPipeline
sudo sh setup-ubuntu.sh
```
3. Restart the Ubuntu server to finish installation
4. Build the Jenkins docker container and run it
```
cd PythonSecurityPipeline
docker-compose up -d --build
```
5. Make sure your firewall allows incoming traffic to port 8080. Then, go to your jenkins server URL 
```
http://your-jenkins-server:8080/
```
6. Input the admin password from the docker logs generated, and create Jenkins user.
```
docker ps
docker logs <your-jenkins-container-name>
```

7. Continue with the setup to get to Jenkins main page
8. Go to Manage Jenkins- Configure Systems - Shell - Shell Executable. Add /bin/bash as the executable for Python's virtualenv to work correctly.

## Setting up a Jenkins Pipeline project manually
1. Click on New Item, input name for your project and select Pipeline as the option and click OK.
2. Scroll down to Pipeline section - Definition, select "Pipeline script from SCM" from drop down menu.
3. Select Git under SCM, and input Repository URL such as `https://github.com/pawnu/jenkinspythondemo.git`
4. (Optional) Create and Add your credentials for the Git repo if your repo is private, and click Save.
5. You will be brought to the Dashboard of your Pipeline project, click on "Build Now" button to start off the pipeline.

## Authors

* **Pawan Uppadey** - *Initial work* - [pawnu](https://github.com/pawnu)

See also the list of [contributors](https://github.com/pawnu/PythonSecurityPipeline/contributors) who participated in this project.

