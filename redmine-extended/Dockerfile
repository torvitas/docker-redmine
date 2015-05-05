FROM torvitas/redmine
MAINTAINER Sascha Marcel Schmidt <docker@saschaschmidt.net>

USER root
RUN yum install unzip patch libuuid-devel libicu-devel which git -y && yum clean all

USER redmine

RUN cd /home/redmine/redmine/plugins/ && curl -L http://www.redmine.org/attachments/download/11500/redmine_bootstrap_kit-0.1.0.tar.gz | tar xz

RUN cd /home/redmine/redmine/plugins/ && git clone https://github.com/taktos/redmine_holidays_plugin.git

RUN cd /home/redmine/redmine/plugins/ && git clone https://github.com/ogom/redmine_sidekiq.git

RUN cd /home/redmine/redmine/plugins/ && git clone https://github.com/speedy32129/time_logger.git 

RUN cd /home/redmine/redmine/plugins/ && git clone https://github.com/danmunn/redmine_dmsf.git

RUN cd /home/redmine/redmine/plugins/ && git clone https://github.com/iRessources/AgileDwarf.git

RUN cd /home/redmine/redmine/plugins/ && git clone https://github.com/phlegx/redmine_gitlab_hook.git

RUN cd /home/redmine/redmine/ && bundle install --without development test

RUN cd /home/redmine/redmine/ && gem install mysql2
