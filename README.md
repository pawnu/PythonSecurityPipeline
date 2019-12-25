# DevSecOps pipeline for Python project

Use this project to create a Jenkins server on AWS Ubuntu 18.04 and DevSecOps pipeline for Python web application

*Disclaimer: This project is for prototype, do not use it for deploying to production*

**TO DO:**
- [x] Select appropriate security tools and sample python project
- [x] Set up Jenkins server using docker (Dockerfile) and pipeline as code (Jenkinsfile) to run the checks
- [x] Use ansible to create AWS ec2 test instance, and configure the environment
- [ ] Hook up the app with nginx+modsecurity providing WAF, DDoS protection, reverse proxy capabilities
- [ ] Bootstrap with Jenkins API/configfile to setup and automatically create the pipeline job
- [ ] Use cloudformation template to automate the whole setup or environment

## Environment configuration manual steps
Assign your ubuntu server IAM role for full ec2 access on your region of choice.

1. Clone this repository to your Ubuntu Server
```
git clone https://github.com/pawnu/PythonSecurityPipeline.git
```
2. Run the setup script to install Docker and docker-compose
```
cd PythonSecurityPipeline
sudo sh setup-ubuntu.sh
```
*Note: docker will be running as root and not ubuntu user*

3. Make sure your firewall allows incoming traffic to port 8080. Then, go to your jenkins server URL 
```
http://your-jenkins-server:8080/
```
4. Input the admin password from the docker logs generated, and create Jenkins user.
```
docker ps
docker logs <your-jenkins-container-name>
```

5. Continue with the setup to get to Jenkins main page

## Setting up a Jenkins Pipeline project manually
1. Click on New Item, input name for your project and select Pipeline as the option and click OK.
2. Scroll down to Pipeline section - Definition, select "Pipeline script from SCM" from drop down menu.
3. Select Git under SCM, and input Repository URL. If you forked this pipeline, you need to update

- AWS region
- AWS subnet id
- AWS security group for test server (allow inbound ssh from everywhere, and inbound from 10007 from your ubuntu-server)

4. (Optional) Create and Add your credentials for the Git repo if your repo is private, and click Save.
5. You will be brought to the Dashboard of your Pipeline project, click on "Build Now" button to start off the pipeline.

## Authors

* **Pawan Uppadey** - *Initial work* - [pawnu](https://github.com/pawnu)

See also the list of [contributors](https://github.com/pawnu/PythonSecurityPipeline/contributors) who participated in this project.

