FROM alpine:3.5

MAINTAINER Shaneen31

ENV NGINX_VERSION 1.11.10

RUN	apk update		&&	\
	apk add				\
		git			\
		gcc			\
		binutils-libs		\
		binutils		\
		gmp			\
		isl			\
		libgomp			\
		libatomic		\
		libgcc			\
		openssl			\
		pkgconf			\
		pkgconfig		\
		mpfr3			\
		mpc1			\
		libstdc++		\
		ca-certificates		\
		libssh2			\
		curl			\
		expat			\
		pcre			\
		musl-dev		\
		libc-dev		\
		pcre-dev		\
		zlib-dev		\
		openssl-dev		\
		make


RUN	cd /tmp/									&&	\
	wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz

RUN	cd /tmp										&&	\
	tar xzf nginx-${NGINX_VERSION}.tar.gz						&&	\
	cd nginx-${NGINX_VERSION}							&&	\
	./configure										\
		--prefix=/opt/nginx								\
		--with-http_ssl_module								&&\
	make										&&	\
	make install

RUN	cd /opt/ 	&&	\
	tar cvzf /tmp/nginx.tar.gz nginx

#ADD nginx.conf /opt/nginx/conf/nginx.conf

EXPOSE 80
EXPOSE 443

CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]