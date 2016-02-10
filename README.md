# Software
Jekyll webserver/blogging platform dockerized with a shared volume to the host

# Installation

Suppose the directory that contains your data is in **/home/myuser/myblog** and the port number that makes the main page accessible is **80**.
```
git clone https://github.com/sofianinho/jekyll.git
EXPORT BLOG_DATA=/home/myuser/myblog
EXPORT BLOG_PORT=80
EXPORT JEKYLL_IMAGE_NAME=jekyll
EXPORT JEKYLL_IMAGE_TAG=persistent
cd jekyll/docker-image
docker build --tag=$JEKYLL_IMAGE_NAME:JEKYLL_IMAGE_TAG .
docker run \
	-it \
	-v $BLOG_DATA:/mnt \
	-p $BLOG_PORT:4000 \
	jekyll:persistent

```
