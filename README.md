# nginx-certbot

Docker Swarm deployment for Nginx edge proxies, with Certbot renewals and log shipping.

## Usage

Tested on Ubuntu 20.04

 - Install and init Docker Swarm.
 - Deploy docker-compose.yaml
 - Install management script
 - Define configuration git repo and deploy new configs with management script

A sample script is in `build-host.sh` assuming you have a /var/nginx-etc directory setup with your config dirs ready for deployment.
The `update-config.sh` script is intended to refresh the hosts /var/nginx-etc directory, test the nginx config, and reload nginx containers
for the service. Both scripts take a single parameter of the target hostname.

## Updating deployment spec

Main definition is docker-compose.yaml. To refresh the kubernetes-deployment.yaml run the following after installing [kompose](https://kompose.io/):

```
kompose convert -o kubernetes-deployment.yaml --volumes hostPath
```
