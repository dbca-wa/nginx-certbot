#!/bin/bash
# run with an ssh key configured for root on each of the hosts
# e.g. ./build-host.sh my-nginx-host.some.domain
pushd /var/nginx-etc/nginx
./testconfig.sh || exit
git commit -am 'testconfig autocommit' && git push
popd
for host in "$@"
do
    rsync -ar /var/nginx-etc/ root@$host:/var/nginx-etc/
    ssh root@$host "k3s kubectl rollout restart deployment nginx"
done
