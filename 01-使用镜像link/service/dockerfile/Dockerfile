FROM jaylin507/nginx-php:v2
MAINTAINER jaylin "jaylin507@foxmail.com"
# Install supervisor
RUN yum install -y python-setuptools
RUN easy_install supervisor

COPY supervisor.conf /usr/etc/supervisord.conf

EXPOSE 80 443
CMD ["/usr/bin/supervisord"]

