#!/bin/sh
docker run -d \
--name supervisord-np \
--restart=always \
-p 80:80 \
-v $(pwd)/logs:/usr/local/nginx/logs/ \
-v $(pwd)/config/php.ini:/usr/local/php/lib/php.ini \
-v $(pwd)/config/php-fpm.conf:/usr/local/php/etc/php-fpm.conf \
-v $(pwd)/config/nginx.conf:/usr/local/nginx/conf/nginx.conf \
-v $(pwd)/../www:/home/www/ \
jaylin507/supervisord-np
