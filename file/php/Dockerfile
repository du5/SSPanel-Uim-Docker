FROM php:7.4-fpm-alpine3.13


RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/main gnu-libiconv \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && echo 'memory_limit = 2048M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so