#!/bin/bash
mysql -u $MYSQLUSER -p$MYSQLPWD -h db < /home/redmine/database/uninstall_redmine.sql
