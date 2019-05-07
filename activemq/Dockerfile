FROM menard99/alpine-openjdk
MAINTAINER menard 2019-03-26

# Application settings
ENV CONFD_PREFIX_KEY="/activemq" \
    LANG="en_US.utf8" \
    APP_HOME="/opt/activemq" \
    APP_VERSION="5.15.8" \
    USER=activemq \
    GROUP=activemq \
    UID=1002 \
    GID=1002 \
    TZ=Asia/Shanghai

# Install extra package
RUN apk --update add bash procps  &&\
    rm -rf /var/cache/apk/*

# Install ActiveMQ software
RUN \
    mkdir -p ${APP_HOME} /data /var/log/activemq  && \
    wget http://archive.apache.org/dist/activemq/${APP_VERSION}/apache-activemq-${APP_VERSION}-bin.tar.gz -O /tmp/activemq.tar.gz &&\
    tar -xf /tmp/activemq.tar.gz -C /tmp &&\
    mv /tmp/apache-activemq-${APP_VERSION}/* ${APP_HOME} &&\
    rm -rf /tmp/activemq.tar.gz &&\
    addgroup -g ${GID} ${GROUP} && \
    adduser -g "${USER} user" -D -h ${APP_HOME} -G ${GROUP} -s /bin/sh -u ${UID} ${USER}


RUN \
    chown -R ${USER}:${GROUP} ${APP_HOME} &&\
    chown -R ${USER}:${GROUP} /data &&\
    chown -R ${USER}:${GROUP} /var/log/activemq

# Expose all port
EXPOSE 8161
EXPOSE 61616
EXPOSE 5672
EXPOSE 61613
EXPOSE 1883
EXPOSE 61614

WORKDIR ${APP_HOME}
USER ${USER}
ENTRYPOINT /opt/activemq/bin/activemq start && /bin/bash
