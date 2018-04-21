FROM jaylin507/nginx-php:v2

# Install supervisor
RUN yum install -y python-setuptools
RUN easy_install supervisor

COPY supervisor.conf /usr/etc/supervisord.conf

EXPOSE 80 443 3306
CMD ["/usr/bin/supervisord"]

