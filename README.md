# DevSecOps pipeline for Python project

Use this project to create a Jenkins server on AWS Ubuntu 18.04 and DevSecOps pipeline for Python web application

![pipeline](https://user-images.githubusercontent.com/11514346/71473164-e57a5500-27cd-11ea-97cb-3c25f0266407.JPG)

*Disclaimer: This project is for demonstration purpose with surface level checks only, do not use it as-is for production*

> **Checkout project** - check out python application project repository with XSS vulnerability

> **git secret check** - check there is no password/token/keys/secrets accidently commited to project github

> **SCA** - check external dependencies/libraries used by the project have no known vulnerabilities

> **SAST** - static analysis of the application source code for exploits, bugs, vulnerabilites

> **Container audit** - audit the container that is used to deploy the python application

> **DAST** - deploy the application, register, login and attack & analyse it from the frontend as authenticated user

> **System security audit** - analyse at the security posture of the system hosting the application

> **WAF** - application deployed with WAF which filters request according to OWASP core ruleset

**Some reports produced**
![reports](https://user-images.githubusercontent.com/11514346/71550657-c3e7bc00-29cd-11ea-8d58-3f4a70bdf7ed.JPG)

## Installation steps

1. Clone this repository to your Ubuntu Server (t2-medium recommended)
```
git clone https://github.com/pawnu/PythonSecurityPipeline.git
```

2. Edit the code to make it work on your AWS
   - Change to your AWS subnet [vpc_subnet_id](jenkins_home/createAwsEc2.yml#L30) 
   - Change to your AWS [security_group](jenkins_home/createAwsEc2.yml#L10) (allow inbound ssh(22), WAF(80), *Optional* web-app(10007) from your IP ONLY)


3. Run the setup script to install Docker and docker-compose
```
cd PythonSecurityPipeline
sudo sh setup-ubuntu.sh
```

4. Make sure your firewall allows incoming traffic to port 8080. Then, go to your jenkins server URL 
```
http://your-jenkins-server:8080/
```
5. Use the temporary credentials provided on bash logs to login. Change your password!

## Setting up a Jenkins Pipeline project manually
 
**A sample pipeline is already provided through automation**

1. Click on New Item, input name for your project and select Pipeline as the option and click OK.
2. Scroll down to Pipeline section - Definition, select "Pipeline script from SCM" from drop down menu.
3. Select Git under SCM, and input Repository URL.
4. (Optional) Create and Add your credentials for the Git repo if your repo is private, and click Save.
5. You will be brought to the Dashboard of your Pipeline project, click on "Build Now" button to start off the pipeline.


**Some wishlists**
- [x] Select appropriate security tools and sample python project
- [x] Set up Jenkins server using docker (Dockerfile) and pipeline as code (Jenkinsfile) to run the checks
- [x] Use ansible to create AWS ec2 test instance, configure the environment, and interact with it
- [x] Hook up the web-app with ~~nginx~~+modsecurity providing WAF, ~~DDoS protection~~, reverse proxy capabilities
- [x] Bootstrap with Jenkins API/configfile to setup and automatically create the pipeline job
- [x] Carry out authenticated DAST scan on the python web app

## Authors

* **Pawan Uppadey** - [pawnu](https://github.com/pawnu)

