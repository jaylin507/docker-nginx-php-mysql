#!/bin/sh
docker run -d \
--name supervisord-np \
--restart=always \
-p 80:80 \
-v ~/docker/web/service/logs:/usr/local/nginx/logs/ \
-v ~/docker/web/service/config/php.ini:/usr/local/php/lib/php.ini \
-v ~/docker/web/service/config/php-fpm.conf:/usr/local/php/etc/php-fpm.conf \
-v ~/docker/web/service/config/nginx.conf:/usr/local/nginx/conf/nginx.conf \
-v ~/docker/web/www:/home/www/ \
jaylin507/supervisord-np
