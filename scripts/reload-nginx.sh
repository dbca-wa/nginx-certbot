#!/bin/bash
docker exec $(docker ps --filter name=nginx_nginx --quiet) bash -c "nginx -t && echo $hostname reloading... && nginx -s reload"
