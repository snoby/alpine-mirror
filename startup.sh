#!/bin/bash

echo "Starting up lighthttpd"
lighttpd -f /etc/lighttpd/lighttpd.conf

echo "Doing a manual sync first"

sh -c "/etc/periodic/hourly/package-rsync" 2>&1 

echo "Startup crond"
crond -d 6

echo "All Processes Starting waiting for kill signal to shutdown..."

while [ "$END" == '' ]; do
    sleep 2
    trap "END=1" INT TERM
done

echo "Shutting Processes "

