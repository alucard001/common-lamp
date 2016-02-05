FROM php:7-apache

# Mainly reference from below Dockerfile
# https://hub.docker.com/r/tommylau/php/~/dockerfile/

MAINTAINER Ellery Leung <elleryleung@esdlife.com>

# Fix docker-php-ext-install script error
RUN sed -i 's/docker-php-\(ext-$ext.ini\)/\1/' /usr/local/bin/docker-php-ext-install

# Failed list
# docker-php-ext-install gmp \
# docker-php-ext-install pdo_firebird \
# docker-php-ext-install oci8 \
# docker-php-ext-install odbc \
# docker-php-ext-install pcntl \
# docker-php-ext-install pdo_dblib \
# docker-php-ext-install pdo_firebird \
# docker-php-ext-install pdo_oci \
# docker-php-ext-install pdo_odbc \
# docker-php-ext-install readline \
# docker-php-ext-install snmp \
# docker-php-ext-install sysvmsg \
# docker-php-ext-install sysvsem \
# docker-php-ext-install sysvshm \

# IMAP - failed
#RUN apt-get update && apt-get install -y libc-client-dev \
#	&& docker-php-ext-configure imap --with-kerberos --with-imap --with-imap-ssl \
#	&& docker-php-ext-install imap;

#====================================  For Test Install Only===================================

#RUN apt-get update && apt-get install -y && docker-php-ext-install sqlite3 pdo_sqlite
#RUN apt-get update && apt-get install -y firebird2.5-dev && docker-php-ext-install interbase
#RUN apt-get update && apt-get install -y libpcre3-dev libxml2-dev && docker-php-ext-install xmlreader
#RUN apt-get update && docker-php-ext-install xmlreader

#=============================================================================================

RUN apt-get update && apt-get install -y \
		unzip \
		vim \
		apt-utils \
		git \
		openssl \
		curl \
		wget \
		libbz2-dev \
		libxslt-dev \
		libpq-dev \
		libmemcached-dev \
		libicu-dev \
		libmcrypt-dev \
		g++ \
		libfreetype6-dev \
		libfreetype6 \
		libjpeg62-turbo \
		libjpeg62-turbo-dev \
		libpng12-dev \
		libpng12-0 \
		libsqlite3-dev \
		libssl-dev \
		libcurl3-dev \
		libxml2-dev \
		libzzip-dev	\
		libjpeg-dev \
		libldap2-dev \
		zlib1g-dev \
		libcurl4-openssl-dev \
		libssl-dev \
		bison \
		librecode-dev \
		libreadline-dev \
		libpspell-dev \
		libmcrypt4 \
		libenchant-dev \
		firebird2.5-dev \
		libtidy-dev \
		libgmp-dev \
		libxslt1-dev \
		libsnmp-dev \
		freetds-dev \
		unixodbc-dev \
		libpcre3-dev \
		libsasl2-dev \
		libmhash-dev \
		libxpm-dev \
		libgd2-xpm-dev \
#		libcurl4-gnutls-dev \
		re2c \
		file \
		libpng3 \
		libpng++-dev \
		libvpx-dev \
		libgd-dev \
		libmagic-dev \
		libexif-dev \
		libssh2-1-dev \
&& docker-php-ext-install enchant \
&& docker-php-ext-install ctype \
&& docker-php-ext-install dom \
&& docker-php-ext-install exif \
&& docker-php-ext-install fileinfo \
&& docker-php-ext-install gettext \
&& docker-php-ext-install pdo \
&& docker-php-ext-install posix \
&& docker-php-ext-install pspell \
&& docker-php-ext-install shmop \
&& docker-php-ext-install soap \
&& docker-php-ext-install sockets \
&& docker-php-ext-install wddx \
&& docker-php-ext-install interbase \
&& docker-php-ext-install xmlwriter \
&& docker-php-ext-install opcache \
&& docker-php-ext-install mbstring \
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-install pdo_pgsql \
&& docker-php-ext-install intl \
&& docker-php-ext-install pgsql \
&& docker-php-ext-install bz2 \
&& docker-php-ext-install xsl \
&& docker-php-ext-install mcrypt \
&& docker-php-ext-install iconv \
&& docker-php-ext-install json \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install pdo_sqlite \
&& docker-php-ext-install phar \
&& docker-php-ext-install curl \
&& docker-php-ext-install ftp \
&& docker-php-ext-install hash \
&& docker-php-ext-install session \
&& docker-php-ext-install simplexml \
&& docker-php-ext-install tokenizer \
&& docker-php-ext-install xml \
&& docker-php-ext-install xmlrpc \
&& docker-php-ext-install zip \
&& docker-php-ext-install bcmath \
&& docker-php-ext-install calendar \
&& docker-php-ext-install dba \
&& docker-php-ext-install tidy \
&& docker-php-ext-configure gd \
	--enable-gd-native-ttf \
	--with-jpeg-dir=/usr/lib/x86_64-linux-gnu \
	--with-png-dir=/usr/lib/x86_64-linux-gnu \
	--with-freetype-dir=/usr/lib/x86_64-linux-gnu \
&& docker-php-ext-install gd \
&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && docker-php-ext-install ldap

RUN pecl install -f apcu mongo redis memcached xdebug

# Install Composer for Laravel
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Setup timezone to Etc/UTC
#RUN cat /usr/src/php/php.ini-production | sed 's/^;\(date.timezone.*\)/\1 \"Etc\/UTC\"/' > /usr/local/etc/php/php.ini

# Disable cgi.fix_pathinfo in php.ini
#RUN sed -i 's/;\(cgi\.fix_pathinfo=\)1/\10/' /usr/local/etc/php/php.ini

# Cleanup all downloaded packages
RUN apt-get -y autoclean && apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/* && cd /usr/src/php && make clean && apt-get update

# Enable necessary modules in Apache 2
RUN a2enmod rewrite
RUN a2enmod expires
RUN a2enmod mime
RUN a2enmod filter
RUN a2enmod deflate

# Restart Apache after enable
RUN service apache2 restart

# Create and switch to web directory
RUN mkdir -p /var/www/html

WORKDIR /var/www/html

