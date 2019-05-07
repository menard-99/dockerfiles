FROM centos:7
USER root
ADD jenkins-2.150.3-1.1.noarch.rpm /tmp
#ADD jdk-8u201-linux-x64.tar.gz /usr/local/
RUN rpm -ivh /tmp/jenkins-2.150.3-1.1.noarch.rpm  --force --nodeps && rm -rf /tmp/jenkins-2.150.3-1.1.noarch.rpm \
	&& yum install -y git \
	&& yum install -y initscripts \
	&& ln -s  /var/jenkins_home/tools/jdk1.8.0_181/bin/java /usr/bin/java \
	&& touch /var/log/jenkins/jenkins.log && chown 999:998 /var/log/jenkins/jenkins.log \
	&& usermod -d /var/jenkins_home/ jenkins \
	&& ln -s /var/jenkins_home/tools/jenkins.plugins.nodejs.tools.NodeJSInstallation/NodeJS/bin/node /usr/bin/node

COPY jenkins /etc/init.d/jenkins
COPY etc/jenkins /etc/sysconfig/jenkins
COPY docker-entrypoint.sh /usr/sbin/docker-entrypoint.sh

ENV PATH=$PATH:/var/jenkins_home/tools/jdk1.8.0_181/bin:/var/jenkins_home/tools/apache-maven-3.6.0/bin:/var/jenkins_home/tools/jenkins.plugins.nodejs.tools.NodeJSInstallation/NodeJS/bin
ENV JENKINS_HOME=/var/jenkins_home JAVA_HOME=/var/jenkins_home/tools/jdk1.8.0_181 CLASSPATH=.:${JAVA_HOME}/jre/lib/rt.jar:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar

WORKDIR /var/jenkins_home/
CMD docker-entrypoint.sh
