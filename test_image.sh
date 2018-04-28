#!/bin/bash

# Stop execution if a step fails
set -e

DOCKER_USERNAME=lantaros # Replace by your docker hub username
IMAGE_NAME=lbaw1714

# Ensure that dependencies are available
composer install
php artisan clear-compiled
php artisan optimize

docker build -t $DOCKER_USERNAME/$IMAGE_NAME .