FROM php:5.5-apache

RUN apt-get update && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    unzip libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev

ADD https://github.com/flarum/flarum/releases/download/v0.1.0-beta.2/flarum-0.1.0-beta.2.zip /flarum.zip
RUN unzip /flarum.zip -d /var/www/html && \
    chown -R www-data:www-data /var/www/html

RUN a2enmod rewrite && \
    docker-php-ext-install iconv mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd

RUN docker-php-ext-install mbstring pdo_mysql

ADD config.php /var/www/html/_config.php
ADD install.php /var/www/html/install.php
