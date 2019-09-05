FROM jenkins/jenkins:lts-jdk11
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
RUN pip install virtualenv
#Install python dependency checker
RUN pip install safety

# drop back to the regular jenkins user - good practice
USER jenkins

#Install git history checker for jenkins user
RUN mkdir -p ~/.talisman/bin
RUN ls
ENV PATH="$HOME/.talisman/bin/:${PATH}"
RUN echo "$PATH"
ENV TALISMAN_HOME="$HOME/.talisman/bin"
RUN echo "$TALISMAN_HOME"
RUN curl --silent  https://raw.githubusercontent.com/thoughtworks/talisman/master/global_install_scripts/install.bash > /tmp/install_talisman.bash
RUN /bin/bash -c "/tmp/install_talisman.bash"]
#RUN ["/bin/bash", "source ~/.talisman/bin"]
