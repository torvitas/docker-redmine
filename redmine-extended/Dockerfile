FROM torvitas/redmine
MAINTAINER Sascha Marcel Schmidt <docker@saschaschmidt.net>

USER root
RUN yum install unzip patch libuuid-devel libicu-devel which git -y && yum clean all

USER redmine
RUN cd /home/redmine/redmine-2.6.0/plugins/ && curl -O http://redminecrm.com/license_manager/15337/redmine_agile-1_3_5-light.zip && unzip redmine_agile-1_3_5-light.zip && rm redmine_agile-1_3_5-light.zip

RUN cd /home/redmine/redmine-2.6.0/plugins/ && curl -L http://www.redmine.org/attachments/download/11500/redmine_bootstrap_kit-0.1.0.tar.gz | tar xz

RUN cd /home/redmine/redmine-2.6.0/plugins/ && git clone https://github.com/taktos/redmine_holidays_plugin.git

RUN cd /home/redmine/redmine-2.6.0/plugins/ && git clone https://github.com/ogom/redmine_sidekiq.git

RUN cd /home/redmine/redmine-2.6.0/plugins/ && git clone https://github.com/speedy32129/time_logger.git 

RUN cd /home/redmine/redmine-2.6.0/plugins/ && git clone https://github.com/danmunn/redmine_dmsf.git

RUN cd /home/redmine/redmine-2.6.0/plugins/ && git clone https://github.com/iRessources/AgileDwarf.git

RUN cd /home/redmine/redmine-2.6.0/plugins/ && git clone https://github.com/phlegx/redmine_gitlab_hook.git

RUN cd /home/redmine/redmine-2.6.0/plugins/ && curl -O http://redminecrm.com/license_manager/16457/redmine_checklists-3_0_2-light.zip && unzip redmine_checklists-3_0_2-light.zip && rm redmine_checklists-3_0_2-light.zip

RUN cd /home/redmine/redmine-2.6.0/ && bundle install --without development test

RUN cd /home/redmine/redmine-2.6.0/ && gem install mysql2

RUN cd /home/redmine/redmine-2.6.0/public/themes/ && curl -O http://redminecrm.com/license_manager/11619/circle_theme-1_0_2.zip && unzip circle_theme-1_0_2.zip && rm circle_theme-1_0_2.zip
