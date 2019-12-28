FROM jenkins/jenkins:lts
MAINTAINER pawan uppadey <pawan.uppadey@gmail.com>

#Install Jenkins plugin to make this pipeline work
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

#Copy script to auto create user to jenkins init folder
COPY setupJenkins.groovy /usr/share/jenkins/ref/init.groovy.d/

#setup the docker container for scanners
USER root
RUN apt-get update && apt-get install -y \
	python-pip \
	curl \
	maven \
	git \
	perl \
	wget \
	kbtin \
	libnet-ssleay-perl \
	software-properties-common

#add public key for the multiverse repo which has nikto
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
RUN add-apt-repository 'deb http://archive.ubuntu.com/ubuntu bionic multiverse'
RUN add-apt-repository 'deb http://archive.ubuntu.com/ubuntu bionic-security multiverse'
RUN add-apt-repository 'deb http://archive.ubuntu.com/ubuntu bionic-updates multiverse'

RUN apt-get update -y
RUN apt-get install -y nikto	
	
#Install virtualenv to isolate each project dependencies
RUN pip install virtualenv
#Install python SCA tool/dependency checker, license check
RUN pip install safety
RUN pip install liccheck
#Install the git history checker for secrets
RUN pip install trufflehog
#Install python SAST tool
RUN pip install bandit

# Used for authenticated DAST scan
RUN pip install selenium

#install the orchestration tool, boto for ec2 module, some lib upgrade under requests
RUN pip install ansible
RUN pip install boto 
RUN pip install boto3

# configure ansible to use right keys and not check host auth for this ephemeral/temp aws host
# Not authenticating existing/long-term hosts requiring relogins may lead to mitm.. be careful
COPY ansible.cfg /etc/ansible/ansible.cfg

# drop back to the regular jenkins user - good practice
USER jenkins
