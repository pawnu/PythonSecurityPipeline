FROM jenkins/jenkins:jdk11
#Install Jenkins plugin to make this pipeline work
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

#setup the docker container for scanners
USER root
RUN apt-get update && apt-get install -y \
	python-pip \
	python3 \
	python3-pip \
	curl \
	wget \
	maven \
	git
	
#Install virtualenv to isolate each project dependencies
RUN pip install virtualenv
#Install python SCA tool/dependency checker
RUN pip install safety
#Install the git history checker for secrets
RUN pip install trufflehog
#Install python SAST tool
RUN pip install bandit
#Install DAST tool owasp zap cli version
RUN pip install --upgrade zapcli
#install the orchestration tool
RUN pip install ansible

# drop back to the regular jenkins user - good practice
USER jenkins
