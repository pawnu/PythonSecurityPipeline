# DevSecOps pipeline for Python project

Use this project to create a Jenkins server on AWS Ubuntu 18.04 and DevSecOps pipeline for Python web application

![pipeline](https://user-images.githubusercontent.com/11514346/71473164-e57a5500-27cd-11ea-97cb-3c25f0266407.JPG)

*Disclaimer: This project is for demonstration purpose with surface level checks only, do not use it as-is for production*

**TO DO:**
- [x] Select appropriate security tools and sample python project
- [x] Set up Jenkins server using docker (Dockerfile) and pipeline as code (Jenkinsfile) to run the checks
- [x] Use ansible to create AWS ec2 test instance, and configure the environment
- [x] Hook up the web-app with ~~nginx~~+modsecurity providing WAF, ~~DDoS protection~~, reverse proxy capabilities
- [x] Bootstrap with Jenkins API/configfile to setup and automatically create the pipeline job
- [ ] Carry out authenticated DAST scan on the python web app
- [ ] Use cloudformation template to automate the whole setup or environment

## Installation steps

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
4. Use the temporary credentials provided on bash logs to login. Change your password!
5. You need to update the following code varaibles in order for this project to work on your AWS


- Assign your ubuntu server IAM role for full ec2 access on eu-west-2 region
- Change AWS subnet [vpc_subnet_id](jenkins_home/createAwsEc2.yml#L30) 
- Change AWS [security_group](jenkins_home/createAwsEc2.yml#L10) in code (allow inbound ssh and 10007 from your ubuntu-server's security group)


*This is to be automated later with ansible/CloudFormation*

## Setting up a Jenkins Pipeline project manually (sample pipeline already provided through automation)

1. Click on New Item, input name for your project and select Pipeline as the option and click OK.
2. Scroll down to Pipeline section - Definition, select "Pipeline script from SCM" from drop down menu.
3. Select Git under SCM, and input Repository URL.
4. (Optional) Create and Add your credentials for the Git repo if your repo is private, and click Save.
5. You will be brought to the Dashboard of your Pipeline project, click on "Build Now" button to start off the pipeline.

## Authors

* **Pawan Uppadey** - [pawnu](https://github.com/pawnu)

