FROM nginx:1.19.6
LABEL org.opencontainers.image.source https://github.com/dbca-wa/nginx-certbot

RUN apt-get -y update; apt-get install -y apt-transport-https wget gnupg; \
    wget -qO - https://apt.signalsciences.net/release/gpgkey | apt-key add -; \
    echo deb https://apt.signalsciences.net/release/debian/ buster main >> /etc/apt/sources.list.d/sigsci-release.list; \
    apt-get -y update
RUN apt-get -y install nginx-module-sigsci-nxo=1.19.6* sigsci-agent
