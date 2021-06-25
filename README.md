# SSPanel-Uim-Docker


### 下载源代码
```bash
git clone --recurse-submodules --depth=1 https://github.com/du5/SSPanel-Uim-Docker && cd SSPanel-Uim-Docker
# git submodule update --remote # 可选, 拉取 SSPanel-Uim 最新代码
```

### 安装 PHP 依赖

```bash 
# rm -rf SSPanel-Uim/vendor SSPanel-Uim/composer.lock # 可选, 删除旧依赖重新安装
docker run --rm -v $PWD/SSPanel-Uim:/app composer install --ignore-platform-reqs
```

### 启动

```bash
# 数据库文件位置 /var/lib/mysql
# 时区 Asia/Shanghai
# 可通过 docker-compose.yaml 配置文件修改
docker-compose up -d
```

### 创建数据库

```bash
docker exec -i mariadb sh -c 'exec mysql -uroot -p"$MARIADB_ROOT_PASSWORD" -e"SET NAMES \"utf8\";CREATE DATABASE sspanel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;use sspanel;source /tmp/sql/glzjin_all.sql;"'
```

### 复制配置文件

```bash
cp SSPanel-Uim/config/.config.example.php SSPanel-Uim/config/.config.php
cp SSPanel-Uim/config/appprofile.example.php SSPanel-Uim/config/appprofile.php
# 修改配置文件，数据库地址为 mariadb
# pma 访问地址 http://<当前ip>:888
# 主机名 mariadb 用户 root
# 密码查看或修改请通过 docker-compose.yaml 文件
sed -i "s|\\$_ENV['db_host']      = '';|\\$_ENV['db_host']      = 'mariadb';|" SSPanel-Uim/config/.config.php # 修改数据库 host
sed -i "s|www:www|www-data:www-data|" SSPanel-Uim/config/.config.php # 修改 php 用户组
# vim SSPanel-Uim/config/.config.php # 修改其他配置文件
```

### 设置 php 权限

```bash
docker exec -i php sh -c 'exec chmod -R 755 `pwd`'
docker exec -i php sh -c 'exec chown -R www-data:www-data `pwd`'
```

### 创建管理员并同步用户

```bash

docker exec -i php sh -c 'exec php xcat User resetTraffic'
docker exec -i php sh -c 'exec php xcat Tool initQQWry'
docker exec -i php sh -c 'exec php xcat ClientDownload'
```

### 配置定时任务

```bash
30 22 * * * docker exec -i php sh -c 'exec php xcat SendDiaryMail' 
0 0 * * * docker exec -i php sh -c 'exec php -n xcat Job DailyJob'
* * * * * docker exec -i php sh -c 'exec php xcat Job CheckJob'
```

### 停止面板(~~跑路~~)

```bash
# 在项目根目录下执行
docker-compose down
# 该命令不会删除数据库, 如需删库跑路需要额外执行吓一条命令
# rm -rf /var/lib/mysql
```