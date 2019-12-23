FROM jenkins/jenkins:jdk11
MAINTAINER pawan uppadey <pawan.uppadey@gmail.com>

#Install Jenkins plugin to make this pipeline work
#COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

#setup the docker container for scanners
USER root
RUN apt-get update && apt-get install -y \
	python-pip \
	python3 \
	python3-pip \
	curl \
	maven \
	git \
	perl \
	wget \
	lynis
# configure ansible to use right keys and not check host auth for ephemeral hosts
# not checking hosts for long term hosts may lead to mitm..
COPY ansible.cfg /etc/ansible/ansible.cfg

# drop back to the regular jenkins user - good practice
USER jenkins
