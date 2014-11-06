# Redmine Docker Container

## Description
The purpose of this project is to be able to easily create a redmine container and a systemd service controlling its lifecycle.

## Quickstart
Edit the database credentials in make.d/configuration.
`$ make pull && make install && make run`
This pulls the image from the docker registry, installs the systemd service and creates a data only container initializes the database schema for redmine.

## Setup
- for parametrisation you can edit the variables in make.d/configuration or add additional files into make.d
- to just build the image run `$ make`
- instead of building the image you can also pull it from the docker registry by `$ make pull`
- to install the systemd service run `$ make install`
- to run the container run `$ make run`
- to uninstall the container, service and host volume run `$ make uninstall`
    - this only uninstalls containers that match the NAMESPACE variable
    - this does not delete the images
    - this also resets volumes and database
