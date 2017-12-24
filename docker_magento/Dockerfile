# Apache version, so that the container does not exit right away.
FROM php:7.1-apache

RUN docker-php-ext-install pdo_mysql

# Magento

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
COPY ./auth.json /root/.composer/

RUN apt-get update && apt-get install -y libjpeg-dev libpng-dev libfreetype6-dev libmcrypt-dev libicu-dev libxslt1-dev zip

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd mcrypt mbstring zip intl xsl soap

RUN apt-get install -y vim

COPY ./install_magento.sh /root/
COPY ./app /root/app

WORKDIR /var/www/html
