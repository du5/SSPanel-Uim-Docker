FROM php:8.3-fpm-alpine

RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv \
    && apk add --no-cache tzdata libzip-dev imap-dev krb5-dev openssl-dev yaml-dev \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install redis yaml \
    && docker-php-ext-enable redis yaml \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && apk del .build-deps \
    && docker-php-ext-install -j$(nproc) zip mysqli pdo pdo_mysql bcmath imap \
    && echo 'memory_limit = 2048M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i "s|error_reporting = E_ALL \\& ~E_DEPRECATED \\& ~E_STRICT|error_reporting = E_COMPILE_ERROR\\|E_RECOVERABLE_ERROR\\|E_ERROR\\|E_CORE_ERROR |" /usr/local/etc/php/php.ini \
    && echo 'access.log = /dev/null' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'listen.backlog = -1' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'pm = dynamic' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'pm.max_children = 10' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'pm.start_servers = 2' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'pm.min_spare_servers = 1' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'pm.max_spare_servers = 6' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'pm.max_requests = 1024' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'pm.process_idle_timeout = 10s' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'request_terminate_timeout = 100' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'request_slowlog_timeout = 0' >> /usr/local/etc/php-fpm.d/zz-docker.conf

ENV LD_PRELOAD=/usr/lib/preloadable_libiconv.so