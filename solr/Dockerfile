FROM openjdk:8-jre-alpine
MAINTAINER menard menard99@qq.com 2019-05-06
COPY solr-5.5.5 /opt/solr
COPY mmseg4j /opt/solr/dist/mmseg4j
COPY docker-entrypoint.sh /usr/sbin/docker-entrypoint.sh
RUN  apk add --no-cache bash \
	&& addgroup -g 1001 -S solr \
	&& adduser solr -D -G solr -u 1001 \
	&& mkdir /etc/default/ /opt/solr/server/logs \
	&& chown -R solr:solr /opt/solr/ \
	&& ln -s /opt/solr/bin/init.d/solr /etc/init.d/solr \
	&& ln -s /opt/solr/bin/solr.in.sh /etc/default/solr.in.sh 
EXPOSE 8983
WORKDIR /opt/solr
CMD docker-entrypoint.sh
