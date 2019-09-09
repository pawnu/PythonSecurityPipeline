FROM jenkins/jenkins:jdk11
#Install Jenkins plugin to make this pipeline work
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

#setup the docker container for scanners
USER root
RUN apt-get update && apt-get install -y \
	python-pip \
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
# drop back to the regular jenkins user - good practice
USER jenkins

#Steps to install talisman not working
#RUN mkdir -p ~/.talisman/bin
#ENV PATH="$HOME/.talisman/bin/:${PATH}"
#ENV TALISMAN_HOME="$HOME/.talisman/bin"
#RUN curl --silent  https://raw.githubusercontent.com/thoughtworks/talisman/master/global_install_scripts/install.bash > /tmp/install_talisman.bash
#TODO: ?Can't seem to get below command not working
#RUN ["/bin/bash", "-c", "/tmp/install_talisman.bash"]
