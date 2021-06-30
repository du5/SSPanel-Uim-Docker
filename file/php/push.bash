#!/bin/bash
docker pull  php:7.4-fpm-alpine3.13
docker buildx build --platform linux/ppc64le,linux/arm64/v8,linux/amd64,linux/s390x,linux/arm/v7,linux/arm/v6,linux/386 ./file/php --push  -t gtary/php:ssp