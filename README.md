# nginx-certbot-logstash
Kubernetes deployment for nginx edge proxies, with certbot renewals and logstash json forwarding

## Usage

 - Install k3s
 - Deploy kubernetes-deployment.yaml
 - Install management script
 - Define configuration git repo and deploy new configs with management script


## Updating deployment spec
Main definition is docker-compose.yaml. To refresh the kubernetes-deployment.yaml run the following after installing [kompose](https://kompose.io/):

```
kompose convert -o kubernetes-deployment.yaml --volumes hostPath
```
