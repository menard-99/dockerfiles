FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y  rsync

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/jenkins_home/tools/jdk1.8.0_181/bin:/var/jenkins_home/tools/apache-maven-3.6.1/bin:/var/jenkins_home/tools/jenkins.plugins.nodejs.tools.NodeJSInstallation/NodeJS/bin"
#ENV PATH=$PATH:/var/jenkins_home/tools/jdk1.8.0_181/bin:/var/jenkins_home/tools/apache-maven-3.6.0/bin:/var/jenkins_home/tools/jenkins.plugins.nodejs.tools.NodeJSInstallation/NodeJS/bin
ENV JENKINS_HOME=/var/jenkins_home JAVA_HOME=/var/jenkins_home/tools/jdk1.8.0_181 JAVA_OPTS=-XX:CompileCommand=exclude,org/hibernate/cfg/annotations/SimpleValueBinder,setType 

WORKDIR /var/jenkins_home/
USER jenkins
