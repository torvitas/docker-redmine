#!/bin/bash
cd /var/www/redmine
rake generate_secret_token
RAILS_ENV=production rake db:migrate
/run-apache.sh
