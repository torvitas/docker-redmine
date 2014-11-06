#!/bin/bash
SERVER_NAME="redmine"

RAILS_ENV="production"

REDMINE_PATH="$HOME/redmine"
CONFIG_FILE="$HOME/etc/puma.rb"

BIND_URI="tcp://0.0.0.0:9292"

THREADS="0:8"
WORKERS=4

echo "Start Puma Server..."
puma --preload --bind $BIND_URI \
	--environment $RAILS_ENV --dir $REDMINE_PATH \
	--workers $WORKERS --threads $THREADS \
	--tag $SERVER_NAME \
	--config $CONFIG_FILE
