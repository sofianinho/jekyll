#!/bin/bash
# Please adapt the env variables at your convinience
EXPORT BLOG_DATA=$PWD/data
EXPORT BLOG_PORT=80
EXPORT JEKYLL_IMAGE_NAME=jekyll
EXPORT JEKYLL_IMAGE_TAG=persistent
EXPORT JEKYLL_DIR=$PWD

cd jekyll/docker-image

docker build --tag=$JEKYLL_IMAGE_NAME:JEKYLL_IMAGE_TAG .

cd $JEKYLL_DIR

docker run \
        -it \
        -v $BLOG_DATA:/mnt \
        -p $BLOG_PORT:4000 \
        jekyll:persistent

