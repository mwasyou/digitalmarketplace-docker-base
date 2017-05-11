#!/bin/sh

echo "${PROXY_AUTH_CREDENTIALS}" >> /etc/nginx/.htpasswd

sed -i "s/{DM_APP_NAME}/$DM_APP_NAME/g" /etc/nginx/nginx.conf

exec /usr/sbin/nginx
