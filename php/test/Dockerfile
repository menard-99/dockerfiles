FROM test:test

MAINTAINER menard 2019-04-08

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
	
	#安装libiconv
	&& cd /tmp \
	&& for tar in *.tgz;  do tar xvf $tar -C /tmp; done \
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
	
	#安装memcache扩展
	&& cd /tmp/memcache-3.0.8 \
	&& /wdata/server/php/bin/phpize \
	&& ./configure --with-php-config=/wdata/server/php/bin/php-config \
	&& make \
	&& make install \
	
	&& rm -rf /tmp/* \
	&& ln -s /wdata/server/php/sbin/php-fpm /usr/sbin/php-fpm
	#apk del mypacks删掉虚拟组包，能使容器小很多
	#&& apk del mypacks

COPY php.ini /wdata/server/php/etc/		
EXPOSE 9000
WORKDIR /wdata/server/php/

STOPSIGNAL SIGTERM

CMD ["php-fpm", "-g", "daemon off;"]
