#!/bin/bash

# Directory where your application is deployed
DEPLOY_DIR="/home/nmcdev/sandbox-nmc-website"

# Navigate to the deployment directory
cd $DEPLOY_DIR || exit

# Pull the latest changes from the main branch
git pull origin main

# Update submodules
git submodule update --init --recursive

# Restart the Apache service in the webserver-prod docker container.
docker exec webserver-prod service apache2 restart

echo "Deployment completed and Apache restarted."
