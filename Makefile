-include make.d/*

build:
	docker build -t $(DOCKERPREFIX)redmine .

install: systemd-service-folder install-docker-stoprm install-redmine-data
	sudo cp systemd/docker-redmine.service.tmpl $(SYSTEMDSERVICEFOLDER)$(NAMESPACE)-redmine.service
	sudo cp nginx/conf.d/. $(NGINXCONFD)
	sudo sed -i s/$(DOCKERNAMESPACEPLACEHOLDER)/$(DOCKERNAMESPACE)/g $(SYSTEMDSERVICEFOLDER)$(NAMESPACE)-redmine.service
	sudo sed -i s/$(NAMESPACEPLACEHOLDER)/$(NAMESPACE)/g $(SYSTEMDSERVICEFOLDER)$(NAMESPACE)-redmine.service
	sudo sed -i s/$(MARIADBCONTAINERPLACEHOLDER)/$(MARIADBCONTAINER)/g $(SYSTEMDSERVICEFOLDER)$(NAMESPACE)-redmine.service
	sudo systemctl enable $(NAMESPACE)-redmine.service

pull:
	docker pull torvitas/redmine

run:
	sudo systemctl start $(NAMESPACE)-redmine
	echo You have to add "--link $(NAMESPACE)-redmine:puma" and "--volumes-from $(NAMESPACE)-redmine" to the nginx service file.

systemd-service-folder:
	sudo mkdir -p $(SYSTEMDSERVICEFOLDER)

install-docker-stoprm:
	sudo curl -o ~/docker-stoprm.sh https://raw.githubusercontent.com/torvitas/demp/master/scripts/stoprm.sh
	sudo chmod +x /usr/local/bin/docker-stoprm

install-redmine-data:
	sudo mkdir -p $(DOCKERHOSTVOLUMES)$(NAMESPACE)-redmine
	sudo chmod o+w $(DOCKERHOSTVOLUMES)$(NAMESPACE)-redmine
	docker run --name $(NAMESPACE)-redmine-data -v $(DOCKERHOSTVOLUMES)$(NAMESPACE)-redmine/:/home/redmine/redmine/ busybox
	docker run --rm --volumes-from=$(NAMESPACE)-redmine-data --link $(NAMESPACE)-mariadb:db  -e "MYSQLUSER=$(MYSQLUSER)" -e "MYSQLPWD=$(MYSQLPWD)" $(DOCKERPREFIX)redmine /home/redmine/bin/config_redmine.sh
	sudo chmod o-w $(DOCKERHOSTVOLUMES)$(NAMESPACE)-redmine

uninstall:
	-docker run --rm --link $(NAMESPACE)-mariadb:db  -e "MYSQLUSER=$(MYSQLUSER)" -e "MYSQLPWD=$(MYSQLPWD)" $(DOCKERPREFIX)redmine /home/redmine/bin/uninstall_redmine.sh
	-sudo systemctl stop $(NAMESPACE)-redmine
	-sudo systemctl disable $(NAMESPACE)-redmine
	-docker rm $(NAMESPACE)-redmine
	-docker rm $(NAMESPACE)-redmine-data
	-sudo rm -rf $(DOCKERHOSTVOLUMES)$(NAMESPACE)-redmine
	-sudo rm $(SYSTEMDSERVICEFOLDER)$(NAMESPACE)-redmine.service
	-sudo rm $(NGINXCONFD)redmine.web.conf
