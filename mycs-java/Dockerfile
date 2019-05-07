FROM openjdk:8-jre-alpine
MAINTAINER menard menard99@qq.com 2019-4-22
RUN apk add --no-cache tzdata bash \
	&& adduser  -u 1003 -D ngwww 
ADD tarAndStartup-docker.sh /wdata/script/
ENV TZ=Asia/Shanghai
USER ngwww
CMD /wdata/script/tarAndStartup-docker.sh
WORKDIR	/wdata/web/mycs-java
