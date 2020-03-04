#!/bin/bash

# docker volume create localMysql
docker run -d --name localMysql -v localMysql:/var/lib/mysql -v $(pwd):/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=pass -p 3306:3306 mysql
