#! /bin/sh

# add other variables to be subsituted inside default.conf.tempkate
envsubst '${LISTEN_PORT} ${UTP_PATH} ${HASURA_URL} ${APP_VERSION} ${JOBS_RT_URL} ${KC_URL} ${KC_CLIENT_ID} ${SHOW_APP_VERSION} ${AUTHZ_GATEWAY_URL} ${DB_SCHEMA} ${LOCALE}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# run nginx
nginx -g 'daemon off;'
