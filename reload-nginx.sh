#!/bin/bash
docker exec $(docker ps | grep nginx_nginx | awk '{print $1}') bash -c "nginx -t && echo $hostname reloading... && nginx -s reload"
