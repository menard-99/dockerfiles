FROM menard99/alpine-openjdk:8-jre-alpine

MAINTAINER menard 2019-04-11

ENV NEXUS_DIR=/usr/local/nexus-3.15.2-01 TZ=Asia/Shanghai LANG=C.UTF-8

RUN wget -c --tries=0 http://sonatype-download.global.ssl.fastly.net/repository/repositoryManager/3/nexus-3.15.2-01-unix.tar.gz -O /tmp/nexus-3.15.2-01-unix.tar.gz \
	&& tar xf /tmp/nexus-3.15.2-01-unix.tar.gz -C /usr/local/ \
	&& ln -s /usr/local/nexus-3.15.2-01/bin/nexus /usr/bin/nexus \
	&& rm -rf /tmp/*
	
WORKDIR /usr/local/nexus-3.15.2-01

CMD nexus run
