FROM alpine:3.5

MAINTAINER Shaneen31

# Install packages
RUN apk --no-cache add php7
                       php7-fpm \
                       php7-phar \
                       php7-curl \
                       php7-json \
                       php7-zlib \
                       php7-xml \
                       php7-dom \
                       php7-ctype \
                       php7-opcache \
                       php7-zip \
                       php7-iconv \
                       php7-pdo \
                       php7-pdo_mysql \
                       php7-pdo_sqlite \
                       php7-pdo_pgsql \
                       php7-mbstring \
                       php7-session \
                       php7-gd \
                       php7-mcrypt \
                       php7-openssl \
                       php7-sockets \
                       php7-posix \
                       php7-ldap \
                       php7-timezonedb \
                       nginx \
                       ca-certificates \
                       curl \
                       ssmtp \
                       supervisor --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
#COPY src/ /var/www/html/

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=/usr/local/bin/composer

EXPOSE 80 443

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
