#! /bin/sh

# add other variables to be subsituted inside default.conf.tempkate
envsubst '${BE_PATH}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# run nginx
nginx -g 'daemon off;'
