# nginx-certbot

Docker Swarm deployment for Nginx + WAF agent edge proxies, with Certbot renewals and log shipping.

## Usage

Tested on Ubuntu 22.04. This project is used to build and deploy a Docker Swarm stack
intended to be used in conjunction with the department's Nginx and LetsEncrypt configuration.

A sample script (`scripts/build-host.sh`) is included which assumes that you have a `/var/nginx-etc` directory set up
with your config directories, ready for deployment.

## Docker images

The Swarm stack makes use of a number of Docker images, both vendor-supplied and bespoke. The bespoke Dockerfiles were previously managed in this repository, but have subsequently been migrated to their own Git repositories. These are as follows:

- [Nginx with Signal Sciences WAF agent](https://github.com/dbca-wa/nginx-sigsci) - **ghcr.io/dbca-wa/nginx-sigsci** image, this comprises a stock Nginx image with the addition of the Signal Sciences Nginx module and agent installed.
- [Certbot with certbot-dns-multi plugin](https://github.com/dbca-wa/certbot-dns-multi) - **ghcr.io/dbca-wa/certbot-dns-multi** image, this comprises a Certbot image with the certbot-dns-multi plugin installed.

## Upgrading

- Edit and test the bespoke images individually (pushes to GitHub will automatically build and push those images to the GitHub container repository).
- Edit the `docker-compose.yml` file to ensure that the "latest" versions of the nginx and certbot images will be used (not the tagged version).
- Deploy those new images to the local host, check normal functioning: `docker stack deploy nginx -c docker-compose.yaml`
- Assuming all is well, tag the bespoke image repositories, update `docker-compose.yml` to use those tagged image versions, commit and push to GitHub.
