FROM fedora/apache
MAINTAINER "Sascha Marcel Schmidt" <docker@saschaschmidt.net>

RUN yum install -y make apr-devel apr-util-devel curl-devel gcc gcc-c++ git httpd-devel ImageMagick-devel postfix ruby-devel tar wget mariadb mariadb-devel rubygem-rake rubygem-bundler

RUN cd /tmp/ && wget http://www.redmine.org/releases/redmine-2.5.2.tar.gz && tar xfzv redmine-2.5.2.tar.gz && mv redmine-2.5.2 /var/www/redmine && cd /var/www/redmine && mkdir -p public/plugin_assets && chown -R 48:48 files log public/plugin_assets tmp && rm /tmp/redmine-2.5.2.tar.gz && cp config/database.yml.example config/database.yml

RUN cd /var/www/redmine && bundler install --without development test

RUN mkdir -p /usr/local/lib64/ruby/site_ruby/mysql2

RUN cd /usr/local/share/gems/gems/mysql2-0.3.16/ext/mysql2/ && ruby extconf.rb && make && make install

RUN cd /usr/local/share/gems/gems/rmagick-2.13.3/ext/RMagick && ruby extconf.rb && make && make install

RUN cd /var/www/redmine && gem install passenger && /usr/local/bin/passenger-install-apache2-module -a 

COPY httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf
COPY httpd/conf.d/redmine.conf /etc/httpd/conf.d/redmine.conf
COPY httpd/conf.modules.d/10-passenger.conf /etc/httpd/conf.modules.d/10-passenger.conf

RUN chown -R 48.48 /var/www/redmine

VOLUME /var/www/redmine/config

COPY start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]
