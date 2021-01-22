#!/bin/bash
# run with an ssh key configured for root on the target hosts
# e.g. ./build-hosts.sh nginx1.domain nginx2.domain
for host in "$@"
do
    ssh root@$host "apt -y install docker.io=19.03.8-0ubuntu1.20.04.2"
    ssh root@$host "docker swarm init"
    rsync -avr --delete /var/nginx-etc/ root@$host:/var/nginx-etc/
    ssh root@$host "mkdir -p /var/run/nginx-sigsci"
    ssh root@$host "docker stack deploy nginx -c /var/nginx-etc/nginx-certbot-filebeat/docker-compose.yaml"
    ssh root@$host "ln -svf /var/nginx-etc/nginx-certbot-filebeat/reload-nginx.sh /usr/local/bin/reload-nginx"
    ssh root@$host "docker service scale -d nginx_filebeat=0 && sleep 2 && docker service scale -d nginx_filebeat=1"
    ssh root@$host "cp -v /var/nginx-etc/nginx-crons /etc/cron.d/nginx-crons"
done
