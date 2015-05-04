CREATE DATABASE redmine CHARACTER SET utf8;
CREATE USER 'redmine'@'172.17.%.%' IDENTIFIED BY 'my_password';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'172.17.%.%';
