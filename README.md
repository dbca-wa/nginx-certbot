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

# Upgrading

* Edit `Dockerfile` (typically the lines `FROM nginx:1.*` and the `RUN apt-get -y install nginx-module-sigsci-nxo=1.*`).
* Test build the image:  `docker image build --tag ghcr.io/dbca-wa/nginx-sigsci .`
* Edit `Dockerfile.certbot` (typically the lines `FROM certbot/dns-cloudflare:v2.*` and `RUN pip install certbot-dns-azure==2.*`).
* Test build the image: `docker image build --file Dockerfile.certbot --tag ghcr.io/dbca-wa/certbot-dns-cloudflare-azure .`
* Edit the `docker-compose.yml` file to ensure that the "latest" just-built versions of the nginx and certbot images will be used (do not commit this change).
* Deploy those new images to the local host, check normal functioning: `docker stack deploy nginx -c docker-compose.yaml`
* Assuming all is well, tag the two built images, update `docker-compose.yml` to use those tagged versions, commit and push everything
  (commits and images) to GitHub.
