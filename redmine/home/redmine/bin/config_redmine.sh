#!/bin/bash
if [ -z $MYSQLUSER ]
then
	echo "Make sure to set \$MYSQLUSER."
	exit 1
fi

if [ -z $MYSQLPWD ]
then
	echo "Make sure to set \$MYSQLPWD."
	exit 1
fi

redmine_password=$(pwqgen)
echo "###########################################################"
echo "# redmine database password: $redmine_password"
echo "###########################################################"
sed -i s/my_password/$redmine_password/g /home/redmine/database/setupdatabase.sql
sed -i s/my_password/$redmine_password/g /home/redmine/redmine-2.6.0/config/database.yml
mysql -h db -u $MYSQLUSER -p$MYSQLPWD < /home/redmine/database/setupdatabase.sql

cd /home/redmine/redmine
rake generate_secret_token
RAILS_ENV=production rake db:migrate
REDMINE_LANG=en RAILS_ENV=production rake redmine:load_default_data

