#!/bin/bash
# run with an ssh key configured for root on the target hosts
# e.g. ./build-host.sh nginx1.domain nginx2.domain
for host in "$@"
do
    ssh root@$host "curl -sfL https://get.k3s.io | sh -"
    rsync -avr --delete /var/nginx-etc/ root@$host:/var/nginx-etc/
    ssh root@$host "k3s kubectl apply -f /var/nginx-etc/nginx-certbot-logstash/kubernetes-deployment.yaml"
done

