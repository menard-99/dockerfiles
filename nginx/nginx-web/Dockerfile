FROM alpine:3.7

MAINTAINER menard 2019-03-29

ENV NGINX_VERSION=1.14.2 NGINX_DIR=/wdata/server/nginx/ PATH=$PATH:/usr/local/ssl/bin/ TZ=Asia/Shanghai LANG=C.UTF-8


RUN  CONFIG="\
		--prefix=/wdata/server/nginx \
		--modules-path=/usr/lib/nginx/modules \
		--user=ngwww \
		--group=ngwww \
		--with-http_stub_status_module \
		--with-http_ssl_module \
		--with-http_v2_module \
		--with-http_gzip_static_module \
		--with-ipv6 \
		--with-http_sub_module \
		--with-http_dav_module \
		--with-http_realip_module \
		--with-http_mp4_module \
		--with-http_flv_module \
		--with-debug \
		--with-openssl=/usr/local/ssl \
		#安装非官方模块，模块要解压在指定路径
		--add-module=/usr/lib/nginx/modules/echo-nginx-module-0.61rc1  \
		--add-module=/usr/lib/nginx/modules/lua-nginx-module-0.10.9rc7 \
		--add-module=/usr/lib/nginx/modules/nginx-http-concat-master \
		--add-module=/usr/lib/nginx/modules/ngx_devel_kit-0.3.0 \
	" \
	
	&& wget -c --tries=0 https://nginx.org/download/nginx-1.14.2.tar.gz -O /tmp/nginx-1.14.2.tar.gz \
	&& wget -c --tries=0 https://github.com/menard-99/dockerfiles/raw/master/nginx/openssl-1.0.2q.tar.gz -O /tmp/openssl-1.0.2q.tar.gz \
	&& cd /tmp && for tar in *.tar.gz;  do tar xvf $tar -C /tmp; done \
	&& mkdir -p /usr/lib/nginx/modules/ /tmp/src/ \
	&& wget -c --tries=0 https://github.com/menard-99/dockerfiles/raw/master/nginx/echo-nginx-module-0.61rc1.tar.gz -O /tmp/src/echo-nginx-module-0.61rc1.tar.gz \
	&& wget -c --tries=0 https://github.com/menard-99/dockerfiles/raw/master/nginx/lua-nginx-module-0.10.9rc7.tar.gz -O /tmp/src/lua-nginx-module-0.10.9rc7.tar.gz \
	&& wget -c --tries=0 https://github.com/menard-99/dockerfiles/raw/master/nginx/nginx-http-concat-master.tar.gz -O /tmp/src/nginx-http-concat-master.tar.gz \
	&& wget -c --tries=0 https://github.com/menard-99/dockerfiles/raw/master/nginx/ngx_devel_kit-0.3.0.tar.gz -O /tmp/src/ngx_devel_kit-0.3.0.tar.gz \
	&& cd /tmp/src && for tar in *.tar.gz;  do tar xvf $tar -C /usr/lib/nginx/modules/; done \
	
	&& addgroup -g 1002 -S ngwww \
	&& adduser ngwww -D -G ngwww -u 1002 -s /sbin/nologin \
	
	#安装gcc make等不是nginx所需环境的包可以加入虚拟组，编译安装好nginx后再把虚拟组的包删掉
	&& apk add --no-cache --virtual mypacks \
		gcc \
		libc-dev \
		make \
		openssl-dev \
		zlib-dev \
		linux-headers \
		curl \
		gnupg1 \
		libxslt-dev \
		gd-dev \
		geoip-dev \
	&& apk add --no-cache \
		#安装第三方模块所需要的lua
		bash \
		pcre-dev \
		luajit \
		lua-socket \
		lua5.1 \
		lua5.1-dev \
		#安装设置时区的包
		tzdata \
	
	#安装OpenSSL
	&& cd /tmp/openssl-1.0.2q \
	&& ./config \
	&& make \
	&& make install \
	&& make -t \
	&& make depend \
	
	#安装nginx
	&& cd /tmp/nginx-$NGINX_VERSION \
	#解决安装openssl报错问题
	&& sed -i 's#\.openssl/##g' auto/lib/openssl/conf \
	&& ./configure $CONFIG \
	&& make  \   	
	&& make install \
	&& rm -rf /tmp/* \
	&& ln -s /usr/lib/nginx/modules /wdata/server/nginx/modules \
	&& ln -s /wdata/server/nginx/sbin/nginx /usr/sbin/nginx \
	&& chown -R ngwww:ngwww /wdata/server/nginx/ \
	#apk del mypacks删掉虚拟组包，能使容器小很多
	&& apk del mypacks
	
EXPOSE 80
WORKDIR /wdata/server/nginx/

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
