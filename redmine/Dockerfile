FROM fedora:20
MAINTAINER "Sascha Marcel Schmidt" <docker@saschaschmidt.net>

RUN yum install -y passwdqc mariadb mariadb-devel which patch libyaml-devel libffi-devel glibc-headers autoconf gcc-c++ glibc-devel patch readline-devel zlib-devel openssl-devel make bzip2 automake libtool bison ImageMagick-devel && yum clean all
RUN adduser redmine
COPY home/redmine/. /home/redmine/
USER redmine
ENV PATH /home/redmine/.rvm/gems/ruby-2.1.4/bin:/home/redmine/.rvm/gems/ruby-2.1.4@global/bin:/home/redmine/.rvm/rubies/ruby-2.1.4/bin:/home/redmine/.rvm/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/redmine/.local/bin:/home/redmine/bin
RUN curl -L https://get.rvm.io | bash
RUN cd /home/redmine/ && rvm install 2.1.4
RUN cd /home/redmine/ && curl -L https://github.com/redmine/redmine/archive/2.6.0.tar.gz | tar xz && ln -s redmine-2.6.0 redmine
COPY redmine/config/database.yml /home/redmine/redmine/config/database.yml
RUN gem install bundler
RUN cd /home/redmine/redmine/; bundle install --without development test
RUN cd /home/redmine; gem install puma
USER root
RUN cd /home/redmine/redmine-2.6.0; mkdir public/plugin_assets; chown -R redmine:redmine files log tmp public/plugin_assets ../database; chmod -R 755 files log tmp public/plugin_assets
USER redmine
VOLUME /home/redmine/redmine/files
VOLUME /home/redmine/redmine/log
VOLUME /home/redmine/redmine/config
VOLUME /home/redmine/redmine/tmp
VOLUME /home/redmine/redmine/public/plugin_assets
EXPOSE 9292
CMD ["/home/redmine/bin/server_puma.sh"]
