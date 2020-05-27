FROM jenkins/jenkins:lts
USER root
RUN apt-get update && \
        apt-get install software-properties-common -y && \
        apt-add-repository ppa:ansible/ansible -y && \
        apt-get install ansible -y && \
        apt-get install rsync -y

WORKDIR /var/jenkins_home/
user jenkins
ENV PATH /usr/local/openjdk-8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/jenkins_home/tools/hudson.tasks.Maven_MavenInstallation/Maven36/bin
