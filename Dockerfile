FROM nginx:1.23.3
MAINTAINER asi@dbca.wa.gov.au
LABEL org.opencontainers.image.source https://github.com/dbca-wa/nginx-certbot

RUN apt-get update \
  && apt-get install -y apt-transport-https wget gnupg \
  && wget -qO - https://apt.signalsciences.net/release/gpgkey | apt-key add - \
  && echo "deb https://apt.signalsciences.net/release/debian/ bullseye main" >> /etc/apt/sources.list.d/sigsci-release.list \
  && apt-get update \
  && apt-get -y install nginx-module-sigsci-nxo=1.23.3* sigsci-agent \
  && rm -rf /var/lib/apt/lists
