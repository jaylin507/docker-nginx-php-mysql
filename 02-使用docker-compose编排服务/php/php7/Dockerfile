FROM alpine:3.8

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
apk update && apk upgrade && \
apk add --no-cache \
php7 \
php7-bcmath \
php7-common \
php7-ctype \
php7-curl \
php7-dom \
php7-exif \
php7-fpm \
php7-gd \
php7-iconv \
php7-fileinfo \
php7-intl \
php7-json \
php7-mysqli \
php7-mysqlnd \
php7-mbstring \
php7-mcrypt \
php7-openssl \
php7-opcache \
php7-pdo \
php7-pdo_mysql \
php7-pdo_pgsql \
php7-pgsql \
php7-phar \
php7-redis \
php7-session \
php7-simplexml \
php7-soap \
php7-sqlite3 \
php7-tokenizer \
php7-xml \
php7-xmlrpc \
php7-xmlwriter \
php7-xmlreader \
php7-xsl \
php7-zlib \
php7-zip \
php7-redis \
php7-ssh2 \
tzdata && \
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
apk del tzdata && \
rm -rf /var/cache/apk/*

#add iconv source
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

#set auth
RUN set -x \
  && addgroup -g 82 -S www-data \
  && adduser -u 82 -D -s /sbin/nologin -h /var/www -G www-data www-data
RUN mkdir -p /var/log/php7 \
  && chown -R www-data:www-data /var/log/php7 \
  && chmod -R 774 /var/log/php7

EXPOSE 9000
CMD ["/usr/sbin/php-fpm7"]
