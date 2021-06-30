FROM php:7.4-fpm-alpine3.13


RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv \
    && apk add --no-cache tzdata \
    && docker-php-ext-install mysqli pdo pdo_mysql bcmath \
    && echo 'memory_limit = 2048M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so