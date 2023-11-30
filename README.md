# nginx-certbot

Docker Swarm deployment for Nginx edge proxies, with Certbot renewals and log shipping.

## Usage

Tested on Ubuntu 22.04. This project is used to build and deploy a Docker Swarm stack
intended to be used in conjunction with the department's Nginx and LetsEncrypt configuration.

A sample script (`build-host.sh`) is included which assumes that you have a `/var/nginx-etc` directory set up
with your config directories, ready for deployment.

# Upgrading

* Edit `Dockerfile.nginx` (typically the lines `FROM nginx:1.*` and the `RUN apt-get -y install nginx-module-sigsci-nxo=1.*`).
* Test build the image:  `docker image build --file Dockerfile.nginx --tag ghcr.io/dbca-wa/nginx-sigsci .`
* Edit `Dockerfile.certbot` (typically the lines `FROM certbot/dns-cloudflare:v2.*` and `RUN pip install certbot-dns-azure==2.*`).
* Test build the image: `docker image build --file Dockerfile.certbot --tag ghcr.io/dbca-wa/certbot-dns-cloudflare-azure .`
* Edit the `docker-compose.yml` file to ensure that the "latest" just-built versions of the nginx and certbot images will be used (do not commit this change).
* Deploy those new images to the local host, check normal functioning: `docker stack deploy nginx -c docker-compose.yaml`
* Assuming all is well, tag the two built images, update `docker-compose.yml` to use those tagged image versions, commit and push everything
  (commits and images) to GitHub.
