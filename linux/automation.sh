#!/bin/bash

AUTOMATION_DIR=`pwd`

cd ../dockerize/

DOCKER_IMAGE_NAME="julinux/webserver"
DOCKER_IMAGE_TAG=`date "+%Y-%m-%d"`

docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .

docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

cd $AUTOMATION_DIR

export MY_IMAGE_NAME="${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"

envsubst '$MY_IMAGE_NAME' < script.yml > ./new-app.yml

kubectl diff ./new-app.yml
