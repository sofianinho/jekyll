#!/bin/bash
# Entrypoint for the jekyll webserver
# Job summary:
## 1. Look at the /mnt volume
##      (is it initialized ?): Yes -> goto 2
##			      No  -> run the "ruby -S jekyll new . --force" command
## 2. Handle the errors at the end of phase 1 if any (permissions, other)
## 3. Run the Jekyll serve command: 
##  	"ruby -S jekyll serve --host=$IP --port=$PORT --watch --force_polling"
## 4. Handle the periodic backup (if necessary)
##      (is the /mnt volume only accessible in user root?): Yes -> Write in user directory then backup as root
##							     No  -> No backup necessary. Already persistent.
## 5. Handle other interesting commands of Jekyll, if any.
## 6. Handle the exit phase of the docker (in case there is backup or other).
