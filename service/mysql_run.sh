#!/bin/sh
docker run \
--name jay-mysql \
-p 3306:3306 \
-v $(pwd)/logs:/logs \
-v $(pwd)/config/mysql.conf:/etc/mysql/conf.d/docker.cnf \
-e MYSQL_ROOT_PASSWORD=root \
-d mysql
