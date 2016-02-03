FROM php:7-apache

# Mainly reference from below Dockerfile
# https://hub.docker.com/r/tommylau/php/~/dockerfile/
MAINTAINER Ellery Leung <elleryleung@esdlife.com>

# Fix docker-php-ext-install script error
RUN sed -i 's/docker-php-\(ext-$ext.ini\)/\1/' /usr/local/bin/docker-php-ext-install

# Install other needed extensions
RUN apt-get update && apt-get install -y libfreetype6 libcurl4-openssl-dev libbz2-dev libssl-dev bison libxml2-dev libjpeg62-turbo librecode-dev libreadline-dev libpspell-dev libmcrypt4 libxslt-dev libicu-dev libpng12-0 openssl curl wget && rm -rf /var/lib/apt/lists/*

RUN buildDeps=" \
		libfreetype6-dev \
		libjpeg-dev \
		libldap2-dev \
		libmcrypt-dev \
		libpng12-dev \
		zlib1g-dev \
		libpq-dev \
	"; \
	set -x \
	&& apt-get update && apt-get install -y $buildDeps && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --enable-gd-native-ttf --with-jpeg-dir=/usr/lib/x86_64-linux-gnu --with-png-dir=/usr/lib/x86_64-linux-gnu --with-freetype-dir=/usr/lib/x86_64-linux-gnu \
	#&& docker-php-ext-install pgsql \
	#&& docker-php-ext-install pdo_pgsql \
	&& docker-php-ext-install bcmath \
	&& docker-php-ext-install bz2 \
	&& docker-php-ext-install calendar \
	&& docker-php-ext-install ctype \
	&& docker-php-ext-install curl \
	&& docker-php-ext-install dba \
	&& docker-php-ext-install dom \
	#&& docker-php-ext-install enchant \
	&& docker-php-ext-install exif \
	&& docker-php-ext-install fileinfo \
	#&& docker-php-ext-install filter \
	&& docker-php-ext-install ftp \
	&& docker-php-ext-install gettext \
	#&& docker-php-ext-install gmp \
	&& docker-php-ext-install hash \
	&& docker-php-ext-install iconv \
	#&& docker-php-ext-install imap \
	#&& docker-php-ext-install interbase \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install json \
	&& docker-php-ext-install mbstring \
	&& docker-php-ext-install mcrypt \
	&& docker-php-ext-install mysqli \
	#&& docker-php-ext-install oci8 \
	#&& docker-php-ext-install odbc \
	&& docker-php-ext-install opcache \
	#&& docker-php-ext-install pcntl \
	&& docker-php-ext-install pdo \
	#&& docker-php-ext-install pdo_dblib \
	#&& docker-php-ext-install pdo_firebird \
	&& docker-php-ext-install pdo_mysql \
	#&& docker-php-ext-install pdo_oci \
	#&& docker-php-ext-install pdo_odbc \
	#&& docker-php-ext-install pdo_sqlite \
	&& docker-php-ext-install phar \
	&& docker-php-ext-install posix \
	&& docker-php-ext-install pspell \
	#&& docker-php-ext-install readline \
	#&& docker-php-ext-install recode \
	#&& docker-php-ext-install reflection \
	&& docker-php-ext-install session \
	&& docker-php-ext-install shmop \
	&& docker-php-ext-install simplexml \
	#&& docker-php-ext-install snmp \
	&& docker-php-ext-install soap \
	&& docker-php-ext-install sockets \
	#&& docker-php-ext-install spl \
	#&& docker-php-ext-install standard \
	#&& docker-php-ext-install sysvmsg \
	#&& docker-php-ext-install sysvsem \
	#&& docker-php-ext-install sysvshm \
	#&& docker-php-ext-install tidy \
	&& docker-php-ext-install tokenizer \
	&& docker-php-ext-install wddx \
	&& docker-php-ext-install xml \
	#&& docker-php-ext-install xmlreader \
	&& docker-php-ext-install xmlrpc \
	&& docker-php-ext-install xmlwriter \
	&& docker-php-ext-install xsl \
	&& docker-php-ext-install zip \
	&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
	&& docker-php-ext-install ldap \

	&& apt-get purge -y --auto-remove $buildDeps \
	&& cd /usr/src/php \
	&& make clean

# Install Composer for Laravel
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Setup timezone to Etc/UTC
#RUN cat /usr/src/php/php.ini-production | sed 's/^;\(date.timezone.*\)/\1 \"Etc\/UTC\"/' > /usr/local/etc/php/php.ini

# Disable cgi.fix_pathinfo in php.ini
#RUN sed -i 's/;\(cgi\.fix_pathinfo=\)1/\10/' /usr/local/etc/php/php.ini

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN apt-get -y autoclean && apt-get -y autoremove && apt-get update