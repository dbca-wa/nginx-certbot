#!/bin/bash
# run with an ssh key configured for root on the host to build
# e.g. ./build-host.sh my-nginx-host.some.domain
ssh root@$1 "curl -sfL https://get.k3s.io | sh -"
rsync -Pvvar /var/nginx-etc/ root@$1:/var/nginx-etc/
ssh root@$1 "k3s kubectl apply -f https://raw.githubusercontent.com/dbca-wa/nginx-certbot-logstash/main/kubernetes-deployment.yaml"
