# Production Docker deployment for Theia

### Requirements

* [docker] (version `1.12+`)
* [docker-compose] (version `1.10.0+` to support Compose file version `3.0`)


### Application container


### Web server container
This image is optional, you should **not** use it when you have your own reverse-proxy. It is a simple front Web server for the Theia app container. If you use the provided `docker-compose.yml` file, you don't have to configure anything. But if your application container is reachable on custom host and/or port (eg. if you use a container provider), you should add those two environment variables :
* `APP_HOST`: application host address
* `APP_PORT_NUMBER`: application HTTP port

If you plan to upload large files to your Theia instance, Nginx will need to write some temporary files. In that case, the `read_only: true` option on the `web` container should be removed from your `docker-compose.yml` file.

#### Install with SSL certificate
Put your SSL certificate as `./volumes/web/cert/cert.pem` and the private key that has
no password as `./volumes/web/cert/key-no-password.pem`. If you don't have
them you may generate a self-signed SSL certificate.

### Starting/Stopping Docker

#### Start
If you are running docker with non root user, make sure the UID and GID in app/Dockerfile are the same as your current UID/GID
```
mkdir -p ./volumes/ide/theia
chown -R 1000:1000 ./volumes/ide/theia
docker-compose start
```

#### Stop
```
docker-compose stop
```

### Removing Docker

#### Remove the containers
```
docker-compose stop && docker-compose rm
```

#### Remove the data and settings of your Theia instance
```
sudo rm -rf volumes
```

## Update Theia to latest version

First, shutdown your containers to back up your data.

```
docker-compose down
```

Back up your mounted volumes to save your data. If you use the default `docker-compose.yml` file proposed on this repository, your data is on `./volumes/` folder.

Then run the following commands.

```
git pull
docker-compose build
docker-compose up -d
```

Your Docker image should now be on the latest Theia version.

### Requirements

* [docker] (1.12.0+)
