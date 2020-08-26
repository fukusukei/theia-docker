FROM nginx:mainline-alpine

ARG BASIC_AUTH_USERNAME=theia
ARG BASIC_AUTH_PASSWORD=theia_password

# Remove default configuration and add our custom Nginx configuration files
RUN rm /etc/nginx/conf.d/default.conf \
    && apk add --no-cache curl  \
    && apk add --no-cache --virtual basicauth apache2-utils \
    && htpasswd -nbd ${BASIC_AUTH_USERNAME} ${BASIC_AUTH_PASSWORD} > /etc/nginx/.htpasswd  \
    && apk del --purge basicauth

COPY ["./theia", "./theia-ssl", "/etc/nginx/sites-available/"]
COPY ./security.conf /etc/nginx/conf.d/

# Add and setup entrypoint
COPY ./entrypoint.sh /

#Healthcheck to make sure container is ready
HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/var/run", "/etc/nginx/conf.d/", "/var/cache/nginx/"]

