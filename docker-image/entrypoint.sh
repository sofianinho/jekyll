#!/bin/bash

# Entrypoint for the jekyll webserver
# Summary:
## 1. Look at the /mnt volume
##      (is it initialized ?): Yes -> goto 2
##			      No  -> run the "ruby -S jekyll new . --force" command
## TODO 2. Handle the errors at the end of phase 1 if any (permissions, other)
## 3. Run the Jekyll serve command:
##  	"ruby -S jekyll serve --host=$IP --port=$PORT --watch --force_polling"
## 4. Ensure that SIGKILL from docker is sent to Jekyll and not the shell (in case there is backup or other done by jekyll).

JEKYLL_WORKDIR=/mnt

cd $JEKYLL_WORKDIR

if [ "$(ls -A $JEKYLL_WORKDIR)" ]; then
# Not Empty blog dir
 echo "[$(date --rfc-3339=seconds)][INFO] It seems your blog directory is not empty. Jekyll assumes it is already initialized..."
 echo "If you think this is an error, please provide an empty data repository for your blog."
else
# Empty blog dir
 echo "[$(date --rfc-3339=seconds)][INFO] An empty blog repository was provided. Jekyll will now attempt to initialize it..."
 ruby -S jekyll new $JEKYLL_WORKDIR --force
fi

# To best serve, I will take the outgoing interface (the one connected to the Gateway)
EGRESS_IF=$(ip route get 8.8.8.8 |awk -F 'dev' '{print $2}'|awk -F 'src' '{print $1}')
EGRESS_IP=$(ip addr show dev $EGRESS_IF|awk -F "inet " '{print $2}'|cut -d/ -f1)

# EXEC is for jekyll process to take over bash inside the container as PID 1
exec ruby -S jekyll serve --host=$EGRESS_IP --port=$JEKYLL_PORT --watch --force_polling
