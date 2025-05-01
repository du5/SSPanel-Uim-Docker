#!/bin/bash
docker pull php:8.3-fpm-alpine
docker pull nginx:alpine

docker buildx build --platform linux/ppc64le,linux/arm64/v8,linux/amd64,linux/s390x,linux/arm/v7,linux/arm/v6,linux/386 ./file/php --push  -t gtary/ssp:php
docker buildx build --platform linux/ppc64le,linux/arm64/v8,linux/amd64,linux/s390x,linux/arm/v7,linux/arm/v6,linux/386 . --push -t gtary/ssp:nginx