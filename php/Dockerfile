FROM alpine:3.7

MAINTAINER menard 2019-04-08

ENV PHP_VERSION=5.6.40 PHP_DIR=/wdata/server/php/ PATH=$PATH:/wdata/server/php/bin/:/wdata/server/php/sbin/ TZ=Asia/Shanghai LANG=C.UTF-8

#config参数设置
RUN  CONFIG="\
		--prefix=/wdata/server/php \
		--with-config-file-path=/wdata/server/php/etc \
		--with-gd \
		--with-mysql \
		--with-mysqli \
		--with-pdo-mysql  \
		--with-libxml-dir \
		--with-png-dir \
		--with-jpeg-dir \
		--with-zlib \
		--with-freetype-dir \
		--with-bz2 \
		--with-curl \
		--with-mcrypt --with-openssl \
		--with-mhash \
		--with-gettext \
		--with-xmlrpc \
		--enable-soap \
		--enable-mbstring=all \
		--enable-sockets \
		--enable-shared \
		--enable-gd-native-ttf \
		--enable-zip \
		--enable-xml \
		--enable-fpm \
		--enable-inline-optimization \
		--enable-pcntl \
		--enable-bcmath \
		--enable-calendar \
		--with-mysqli=mysqlnd \
		--with-pdo-mysql=mysqlnd \
		--enable-shmop \
		--enable-sysvsem \
		--enable-mbregex \
		--enable-short-tags \
		--with-iconv=/wdata/server/libiconv/ \
	" \
	
	#安装环境
	&& apk add  --no-cache --virtual mypacks \
		autoconf \	
		file \
		g++ \
		gcc \
		make \
		pkgconf \
		re2c \
		coreutils \
		
	&& apk add --no-cache \	
		libc-dev \
		dpkg \
		dpkg-dev \
		curl-dev \
		libedit-dev \
		libxml2-dev \
		libressl-dev \
		sqlite-dev \
		gettext-dev \
		bzip2-dev \
		jpeg-dev \
		libpng-dev \
		freetype-dev \
		libmcrypt-dev \
		tzdata \
		bash \
	
	#下载安装包并解压
	&& wget -c --tries=0 https://www.php.net/distributions/php-5.6.40.tar.gz -O /tmp/php-5.6.40.tar.gz \
	&& wget -c --tries=0 https://pecl.php.net/get/solr-2.4.0.tgz -O /tmp/solr-2.4.0.tgz \
	&& wget -c --tries=0 https://pecl.php.net/get/redis-4.2.0.tgz -O /tmp/redis-4.2.0.tgz \
	&& wget -c --tries=0 https://pecl.php.net/get/memcache-2.2.7.tgz -O /tmp/memcache-2.2.7.tgz \
	&& wget -c --tries=0 https://github.com/menard-99/dockerfiles/raw/master/php/libiconv-1.15.tar.gz -O /tmp/libiconv-1.15.tar.gz \
	&& cd /tmp \
	&& for tar in *.gz;  do tar xvf $tar -C /tmp; done \
	&& for tar in *.tgz;  do tar xvf $tar -C /tmp; done \
	
	#创建安装文件夹和启动用户，启动用户在php-fpm.conf设置，php-fpm.conf和php.ini通过挂载到镜像中使用
	&& mkdir -p /wdata/server \
	&& addgroup -g 1002 -S ngvod \
	&& adduser ngvod -D -G ngvod -u 1002 -s /sbin/nologin \
	
	#安装libiconv
	&& cd /tmp/libiconv-1.15/ \
	&& ./configure --prefix=/wdata/server/libiconv/ \
	&& make \
	&& make install \
	
	#安装PHP
	&& cd /tmp/php-5.6.40 \
	&& ./configure $CONFIG \
	&& make \
	&& make install \
	&& cp -p /wdata/server/php/etc/php-fpm.conf.default /wdata/server/php/etc/php-fpm.conf \
	#docker要把daemonizes设置为no,默认是yes的
	&& sed -i 's/;daemonize = yes/daemonize = no/g' /wdata/server/php/etc/php-fpm.conf \
	
	#安装ftp扩展
	&& cd /tmp/php-5.6.40/ext/ftp/ \
	&& /wdata/server/php/bin/phpize \
	&& ./configure --with-php-config=/wdata/server/php/bin/php-config --enable-ftp \
	&& make \
	&& make install \
	
	#安装redis扩展
	&& cd /tmp/redis-4.2.0 \
	&& /wdata/server/php/bin/phpize \
	&& ./configure --with-php-config=/wdata/server/php/bin/php-config \
	&& make \
	&& make install \
	
	#安装solr扩展
	&& cd /tmp/solr-2.4.0 \
	&& /wdata/server/php/bin/phpize \
	&& ./configure --with-php-config=/wdata/server/php/bin/php-config \
	&& make \
	&& make install \
	
	#安装memcache扩展，版本选择稳定版的，3.0.x测试版5.6的PHP用不了
	&& cd /tmp/memcache-2.2.7 \
	&& /wdata/server/php/bin/phpize \
	&& ./configure --with-php-config=/wdata/server/php/bin/php-config \
	&& make \
	&& make install \
	
	#安装composer
	&& wget -c --tries=0 https://getcomposer.org/download/1.8.0/composer.phar -O /usr/sbin/composer \
	&& chmod +x /usr/sbin/composer \
	
	&& rm -rf /tmp/* \
	&& ln -s /wdata/server/php/sbin/php-fpm /usr/sbin/php-fpm \
	#apk del mypacks删掉虚拟组包，能使容器小很多
	&& apk del mypacks

COPY php.ini /wdata/server/php/etc/		
EXPOSE 9000
WORKDIR /wdata/server/php/

STOPSIGNAL SIGTERM

CMD ["php-fpm", "-g", "daemon off;"]
