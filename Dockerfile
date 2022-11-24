FROM node:13.10.1-buster as build-stage

WORKDIR /app

# Run this step separately to cache dependencies installation
COPY package*.json /app/
ADD local-packages /app/local-packages

#ADD local-packages /app/local-packages
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

COPY --from=build-stage /app/dist/spa/ /usr/share/nginx/html
COPY ./dockerfiles/default.conf.template /etc/nginx/conf.d/default.conf.template
COPY ./dockerfiles/start.sh /usr/share/nginx/start.sh
RUN chmod +x /usr/share/nginx/start.sh

ENTRYPOINT ["/usr/share/nginx/start.sh"]
