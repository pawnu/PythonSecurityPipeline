FROM jenkins/jenkins:lts
MAINTAINER pawan uppadey <pawan.uppadey@gmail.com>

#Install Jenkins plugin to make this pipeline work
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

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
	libnet-ssleay-perl
	
#Install virtualenv to isolate each project dependencies
RUN pip install virtualenv
#Install python SCA tool/dependency checker
RUN pip install safety
#Install the git history checker for secrets
RUN pip install trufflehog
#Install python SAST tool
RUN pip install bandit

#install the orchestration tool, boto for ec2 module, some lib upgrade under requests
RUN pip install ansible
RUN pip install boto 
RUN pip install boto3

# configure ansible to use right keys and not check host auth for ephemeral hosts
# not checking hosts for long term hosts may lead to mitm..
COPY ansible.cfg /etc/ansible/ansible.cfg

# drop back to the regular jenkins user - good practice
USER jenkins
