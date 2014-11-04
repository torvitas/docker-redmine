#!/bin/bash
cd /var/www/redmine
rake generate_secret_token
RAILS_ENV=production rake db:migrate

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/*

exec /usr/sbin/apachectl -D FOREGROUND
