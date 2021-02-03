#!/bin/bash
# run with an ssh key configured for root on the target hosts
# e.g. ./build-hosts.sh nginx1.domain nginx2.domain
for host in "$@"
do
    ssh root@$host "curl -fsSL https://get.docker.com | sh"
    ssh root@$host "docker swarm init"
    rsync -avr --delete /var/nginx-etc/ root@$host:/var/nginx-etc/
    ssh root@$host "mkdir -p /var/log/nginx"
    ssh root@$host "docker stack deploy nginx -c /var/nginx-etc/nginx-certbot-filebeat/docker-compose.yaml"
    ssh root@$host "ln -svf /var/nginx-etc/nginx-certbot-filebeat/reload-nginx.sh /usr/local/bin/reload-nginx"
    ssh root@$host "cp -v /var/nginx-etc/nginx-crons /etc/cron.d/nginx-crons"
done
