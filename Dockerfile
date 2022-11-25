FROM node:14-buster as build-stage

WORKDIR /app

# Run this step separately to cache dependencies installation
COPY package*.json /app/
COPY yarn.lock /app/


RUN npm install
RUN npm install -g @quasar/cli
RUN npm link @quasar/cli
COPY ./ /app/

# Build for production
RUN quasar build --no-progress --prod

FROM nginx:1.17.9-alpine

# Listen port overridable
ENV LISTEN_PORT=80

# Application version environmental variable
ARG APP_VERSION
ENV APP_VERSION=$APP_VERSION

CMD mkdir /etc/nginx/ssl

COPY --from=build-stage /app/dist/spa/ /usr/share/nginx/html
COPY ./default.conf.template /etc/nginx/conf.d/default.conf.template

COPY ./start.sh /usr/share/nginx/start.sh
RUN chmod +x /usr/share/nginx/start.sh

ENTRYPOINT ["/usr/share/nginx/start.sh"]
