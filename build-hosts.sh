#!/bin/bash
# run with an ssh key configured for root on the target hosts
# e.g. ./build-host.sh nginx1.domain nginx2.domain
for host in "$@"
do
    ssh root@$host "apt -y install docker.io"
    ssh root@$host "docker swarm init"
    rsync -avr --delete /var/nginx-etc/ root@$host:/var/nginx-etc/
    ssh root@$host "docker stack deploy nginx -c /var/nginx-etc/nginx-certbot-logstash/docker-compose.yaml"
    ssh root@$host "ln -s /var/nginx-etc/nginx-certbot-logstash/reload-nginx.sh /usr/local/bin/reload-nginx"
done

