#!/bin/bash

echo "Starting up lighthttpd"
lighttpd -f /etc/lighttpd/lighttpd.conf

echo "Startup up rsyncd"
rsync --daemon

echo "All Processes Starting waiting for kill signal to shutdown..."

while [ "$END" == '' ]; do
    sleep 2
    trap "END=1" INT TERM
done

echo "Shutting Processes "

