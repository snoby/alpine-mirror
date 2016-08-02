#!/bin/bash
#
# This is only for running the container on the host
#

app="alpine-mirror"
if docker ps | awk -v app="app" 'NR>1{  ($(NF) == app )  }'; then
  printf "Stopping and removing %s \n" "$app"
  docker stop "$app" && docker rm -f "$app"
fi

docker run -P -d --name=alpine-mirror -v /Users/snoby/work/alpine-cache:/var/www/localhost/htdocs/alpine alpine-mirror

