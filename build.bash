#!/bin/bash

docker build ./file/php -t myphp

rm -rf SSPanel-Uim/vendor SSPanel-Uim/composer.lock 

docker run --rm -v $PWD/SSPanel-Uim:/app composer composer install  --ignore-platform-reqs

docker-compose up -d

sleep 20s 
# 创建数据库
docker exec -i mariadb sh -c 'exec mysql -uroot -p"$MARIADB_ROOT_PASSWORD" -e"SET NAMES \"utf8\";CREATE DATABASE sspanel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;use sspanel;source /tmp/sql/glzjin_all.sql;"'

# 复制配置文件
cp SSPanel-Uim/config/.config.example.php SSPanel-Uim/config/.config.php
cp SSPanel-Uim/config/appprofile.example.php SSPanel-Uim/config/appprofile.php

# 设置 php 权限
docker exec -i php sh -c 'exec chmod -R 755 `pwd`'
docker exec -i php sh -c 'exec chown -R www-data:www-data `pwd`'

docker exec -i php sh -c 'exec php xcat User createAdmin'
docker exec -i php sh -c 'exec php xcat Tool initQQWry'
docker exec -i php sh -c 'exec php xcat ClientDownload'


