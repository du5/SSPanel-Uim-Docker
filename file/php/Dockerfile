FROM php:7.4-fpm-alpine3.13

RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv \
    && apk add --no-cache tzdata \
    && docker-php-ext-install mysqli pdo pdo_mysql bcmath \
    && echo 'memory_limit = 2048M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i "s|error_reporting = E_ALL \\& ~E_DEPRECATED \\& ~E_STRICT|error_reporting = E_COMPILE_ERROR\\|E_RECOVERABLE_ERROR\\|E_ERROR\\|E_CORE_ERROR |" /usr/local/etc/php/php.ini 

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so