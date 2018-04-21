# docker-nginx-php-mysql
编译安装nginx-php基于centos镜像
mysql 直接pull官方镜

nginx:1.9.9
php:7.2.4
mysql:8.0.11


service中有run.sh 和 mysql_run.sh 启动脚本

如需运行脚本需要做一些修改, 对脚本中宿主挂载目录进行修改为你的设定的目录
- ./run.sh 启动nginx-php
- ./mysql_run.sh 启动mysql

--
service/config中有各种配置信息
--
如需在宿主机中通过Navicat等工具连接MySQL，需要先进入容器中设定一个使用mysql_native_password验证的账号
步骤：

