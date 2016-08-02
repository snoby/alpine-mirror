#
# Run lighttpd to serve apk packages
#
FROM    alpine:3.4

RUN     apk --no-cache add lighttpd rsync
ADD     lighttpd.conf /etc/lighttpd/lighttpd.conf

ADD     rsync.sh /etc/periodic/hourly/package-rsync
ADD     exclude.txt /etc/rsync/exclude.txt
ADD     startup.sh /startup.sh
RUN     chmod +x /startup.sh

RUN     mkdir -p /var/www/localhost/htdocs/alpine
#RUN     chmod +x /etc/periodic/hourly/package-rsync

RUN     echo "[alpine]" >> /etc/rsyncd.conf
RUN     echo "path = /var/www/localhost/htdocs/alpine" >> /etc/rsyncd.conf
RUN     echo "comment = My Alpine Linux Mirror" >> /etc/rsyncd.conf

VOLUME  /var/www/localhost/htdocs/alpine

CMD     ["/startup.sh"]
EXPOSE  80

