
# [2017-04-25] docker学习笔记。尝试搭建PHP开发环境。

另一种实现方法，全部都pull官方镜像

## mysql: 
  `docker run --name jay-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d  mysql`
## php:
  `docker run --name jay-php -d -it --link jay-mysql:jay-mysql -v $(pwd)/www:/home -v $(pwd)/config/php.ini:/usr/local/etc/php/php.ini php:7.2-fpm`
## nginx
  `docker run --name jay-nginx -d -p 80:80 --link jay-php:jay-php -v $(pwd)/config/nginx.conf:/etc/nginx/nginx.conf --volumes-from jay-php nginx`
## 说明
* $(pwd)☞当前目录

* 需要按顺序执行，php会关联MySQL，这样在代码里就可以使用别名来访问mysql。另外如果是pull的8.0的数据库，需要参考下面宿主连接MySQL中的设定一个使用mysql_native_password验证的账号

* php.ini 和 nginx.conf 可以参考https://github.com/sungjaylin/docker-nginx-php-mysql/tree/master/service/config

* 修改php.ini配置后需要重启php容器 `docker restart jay-php` //jay-php为run时设定的--name

* 安装php扩展可以进入php容器使用docker提供的脚本安装 `docker exec -it jay-php bash`

* 在 `/usr/local/bin` 目录下有很多docker提供的工具，可以使用`docker-php-ext-install`来进行安装

* 直接执行'./docker-php-ext-install'会显示可安装的扩展，安装pdo扩展则可以这样 `./docker-php-ext-install pdo_mysql`


# [2017-04-23] docker学习笔记。尝试搭建PHP开发环境。
nginx和php基于centos镜像编译安装 ，mysql 是直接pull官方镜像

```
nginx:1.9.9
php:7.2.4
mysql:8.0.11
```
***
## 目录说明
* serviec docker相关目录
  + config 配置文件
    + mysql.conf
    + nginx.conf
    + php-fpm.conf
    + php.ini
  + dockerfile 如果没有改动则无需重新build ，直接运行run.sh脚本即可。
    + Dockerfile 主要是安装supervisor来管理启动php和nginx
    + supervisor.conf 配置php和Ngin的文件，在build的时候会copy进镜像
  + logs 日志文件

  + mysql_run.sh MySQL启动脚本，可以修改其中生成的容器名和默认密码

  + run.sh Nginx+PHP启动脚本，
* www web根目录
  + index.php

```
//启动脚本
* ./run.sh 启动nginx-php  
* ./mysql_run.sh    启动mysql 
```
***
## 宿主连接MySQL
如需在宿主机中通过Navicat等工具连接MySQL，需要先进入容器中设定一个使用mysql_native_password验证的账号
步骤：
* 执行 `./mysql_run.sh`
* `docker exec -it jay-mysql bash` //如果在mysql_run.sh脚本中修改了name,此处-mysql因改为你修改的名字
* 进入容器终端后，执行 `mysql -uroot -p` 然后回车输入密码，密码在mysql_run.sh脚本中设定的，默认root
* `use mysql; ` //进入MySQL交互界面后，选择数据库 
* `create user 'jay'@'%' identified with mysql_native_password by 'jaypassword';` //设置使用mysql_native_password验证的账号
* `grant all privileges on *.* to 'jay'@'%';`  //设置拥有全部权限,如果要设置指定数据库则将 *.* 改为 库名.*
* `flush privileges;` //刷新权限
此时应该就可以在宿主中访问容器内数据库
***
## php容器连接MySQL容器
docker 容器是互通的，可以通过 `docker network inspect bridge` 或其他命令来获取MySQL的容器IP，在php容器中通过这个IP即可连接MySQL

***
## 少量的命令参考，随手记的，更多全面的命令建议查看官方文档

* docker run 创建一个新的容器
  + 参数
  + -i  以交互模式运行容器
  + -t 为容器分配一个伪输入中断，通常和-i组合使用 -it (最后需要跟上 bash 命令)
  + -d 后台运行容器
  + --rm 容器退出后自动删除
  + --name  给容器起名字
  + -e 设置环境变量
  + --restart=always 自动重新启动
  + -p 80:80 绑定宿主端口:容器端口
  + -v /user/jay:/home/www 绑定宿主目录:容器目录
  + -m 设置容器使用内存最大值

* docker build jaylin507/name .  根据dockerfile文件生成镜像   dcker build 名称 目录
* docker exec 进入一个运行中的容器
  + 参数
  + -i  以交互模式运行容器
  + -t 为容器分配一个伪输入中断，通常和-i组合使用 -it (最后需要跟上 bash 命令)
* docker ps 查看运行中容器
  + -a 查看所有
* docker start 启动已停止的容器
* docker stop 停止一个运行中的容器
* docker restart 重启容器
* docker pull 拉取镜像
* docker push 推送镜像

