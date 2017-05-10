#!/bin/sh

echo "${PROXY_AUTH_CREDENTIALS}" >> /etc/nginx/.htpasswd

exec /usr/sbin/nginx
