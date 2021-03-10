#!/bin/bash
# run with an ssh key configured for root on each of the hosts
pushd /var/nginx-etc/nginx
./testconfig.sh || exit
for host in "$@"
do
    rsync -avur /var/nginx-etc/ root@$host:/var/nginx-etc/
    ssh root@$host reload-nginx
done
git commit -am 'pushconfig autocommit'; git push
popd
