#!/bin/sh

# Define default value for app container hostname and port
APP_HOST=${APP_HOST:-ide}
APP_PORT_NUMBER=${APP_PORT_NUMBER:-8080}

# Check if SSL should be enabled (if certificates exists)
if [ -f "/cert/cert.pem" -a -f "/cert/key-no-password.pem" ]; then
  echo "found certificate and key, linking ssl config"
  ssl="-ssl"
else
  echo "linking plain config"
fi
# Ensure that the configuration file is not present before linking. 
test -w /etc/nginx/conf.d/thiea.conf && rm /etc/nginx/conf.d/theia.conf
# Linking Nginx configuration file
ln -s -f /etc/nginx/sites-available/theia$ssl /etc/nginx/conf.d/theia.conf

# Setup app host and port on configuration file
sed -i "s/{%APP_HOST%}/${APP_HOST}/g" /etc/nginx/conf.d/theia.conf
sed -i "s/{%APP_PORT%}/${APP_PORT_NUMBER}/g" /etc/nginx/conf.d/theia.conf

# Run Nginx
exec nginx -g 'daemon off;'
