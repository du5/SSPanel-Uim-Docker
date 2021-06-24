FROM php:fpm-alpine


RUN docker-php-ext-install mysqli pdo pdo_mysql \
    && echo 'memory_limit = 2048M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
