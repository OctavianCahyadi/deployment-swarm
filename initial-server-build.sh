#!/bin/sh

docker network create --driver=overlay traefik-public --attachable=true

export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID
docker node update --label-add portainer.portainer-data=true $NODE_ID
docker node update --label-add registry.data=true $NODE_ID
docker node update --label-add whatsapp.data=true $NODE_ID

export EMAIL=mr.octavianz@gmail.com
export BASE_DOMAIN=yudhadhstr.my.id
export DOMAIN_TREAFIK=traefik.$BASE_DOMAIN
export DOMAIN_PORTAINER=portainer.$BASE_DOMAIN
export DOMAIN_REGISTRY=registry.$BASE_DOMAIN
export DOMAIN_REGISTRY_UI=registry-ui.$BASE_DOMAIN

export WORKDIR=$(pwd)
echo "workdir = ${WORKDIR}"

mkdir -p devops/traefik/cert

docker compose -f treafic.yml pull
docker compose -f portainer.yml pull
docker compose -f registry.yml pull
docker stack deploy traefik -c treafic.yml
docker stack deploy portainer -c portainer.yml
docker stack deploy registry -c registry.yml