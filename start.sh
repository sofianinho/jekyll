#!/bin/bash
# Please adapt the env variables at your convenience
export BLOG_DATA=$HOME/blog/data
export BLOG_PORT=80
export JEKYLL_IMAGE_NAME=jekyll
export JEKYLL_IMAGE_TAG=persistent
export JEKYLL_DIR=$HOME/blog

cd docker-image

# Test if the image already exists
existing_images=$(docker images $JEKYLL_IMAGE_NAME:$JEKYLL_IMAGE_TAG |wc -l)
if [ $existing_images > 1 ]; then
 echo "[INFO] It seems another image with the same name and tag already exists".
 echo -n "Do want to rebuild the image and erase the previous with the same name and tag? [yes/no]"
 read ANSWER
 if [ "$ANSWER" = "yes" ]; then
  echo "[$(date +%D-%X)][INFO] Rebuilding the docker image for Jekyll..."
  docker build --tag=$JEKYLL_IMAGE_NAME:$JEKYLL_IMAGE_TAG .
 fi
else
 echo "[$(date +%D-%X)][INFO] Building the docker image for Jekyll...".
 docker build --tag=$JEKYLL_IMAGE_NAME:$JEKYLL_IMAGE_TAG .
fi

# Start serving the blog
cd $JEKYLL_DIR
exec docker run \
        -ti \
        -v $BLOG_DATA:/mnt \
        -p $BLOG_PORT:4000 \
        $JEKYLL_IMAGE_NAME:$JEKYLL_IMAGE_TAG

