#!/bin/bash
docker run --name redmine-mariadb-data -v /opt/redmine/data/database:/var/lib/mysql busybox true
docker run --rm --volumes-from=redmine-mariadb-data fedora/mariadb /config_mariadb.sh
docker run --name=redmine-mariadb -d -p 3306:3306 --volumes-from=redmine-mariadb-data fedora/mariadb
mysqladmin --protocol=tcp -u testdb -pmysqlPassword password
