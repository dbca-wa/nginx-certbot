#!/bin/bash
# run with an ssh key configured for root on each of the hosts
pushd /var/nginx-etc/nginx
./testconfig.sh || exit
for host in "$@"
do
    rsync -avur root@$host:/var/nginx-etc/letsencrypt/ /var/nginx-etc/letsencrypt/ # pull certs back if updated
    rsync -avur /var/nginx-etc/ root@$host:/var/nginx-etc/
    ssh root@$host "k3s kubectl rollout restart deployment nginx"
done
git commit -am 'pushconfig autocommit' && git push
popd
