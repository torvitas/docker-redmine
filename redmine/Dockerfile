FROM fedora:21
MAINTAINER "Sascha Marcel Schmidt" <docker@saschaschmidt.net>

RUN yum install -y gpg mariadb-devel sqlite-devel passwdqc mariadb mariadb-devel which patch libyaml-devel libffi-devel glibc-headers autoconf gcc-c++ glibc-devel patch readline-devel zlib-devel openssl-devel make bzip2 automake libtool bison ImageMagick-devel && yum clean all
RUN adduser redmine
COPY home/redmine/. /home/redmine/
USER redmine
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && curl -L https://get.rvm.io | bash -s -- stable --ruby
ENV PATH /home/redmine/.rvm/gems/ruby-2.2.1/bin:/home/redmine/.rvm/gems/ruby-2.2.1@global/bin:/home/redmine/.rvm/rubies/default/bin:/home/redmine/.rvm/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/redmine/.local/bin:/home/redmine/bin
RUN cd /home/redmine/ && curl -L https://github.com/redmine/redmine/archive/2.6.2.tar.gz | tar xz && ln -s redmine-2.6.2 redmine
COPY redmine/config/database.yml /home/redmine/redmine/config/database.yml
RUN gem install bundler
RUN cd /home/redmine/redmine/; sed -i -r "s/2\.8\.1/2\.9\.1/g" Gemfile; bundle install --without development test
RUN cd /home/redmine; gem install puma
USER root
RUN cd /home/redmine/redmine; chown -R redmine:redmine files log tmp public/plugin_assets ../database; chmod -R 755 files log tmp public/plugin_assets
USER redmine
VOLUME /home/redmine/redmine/files
VOLUME /home/redmine/redmine/log
VOLUME /home/redmine/redmine/config
VOLUME /home/redmine/redmine/tmp
VOLUME /home/redmine/redmine/public/plugin_assets
EXPOSE 9292
CMD ["/home/redmine/bin/server_puma.sh"]
