#!/bin/bash
docker run --name redmine-data -v /opt/redmine/data/config:/var/www/redmine/config -v /opt/redmine/data/files:/var/www/redmine/files busybox true
