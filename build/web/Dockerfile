FROM ubuntu:16.04
MAINTAINER Ellery Leung <alucard001@gmail.com>

RUN   apt-get update && \
      apt-get install -y  php7* \
                        php-redis \
                        composer \
                        apache2* \
                        vim \
                        python3 \
                        libapache2-mod-php* \
      && apt-get clean \
      && apt-get autoclean

COPY ./php.ini /etc/php/7.0/apache2/php.ini
COPY ./apache2.conf /etc/apache2/apache2.conf

RUN a2enmod rewrite
RUN a2enmod expires
RUN a2enmod headers
RUN service apache2 stop

EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]