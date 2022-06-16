#!/bin/sh

docker network create --driver=overlay traefik-public --attachable=true

export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID
docker node update --label-add portainer.portainer-data=true $NODE_ID
docker node update --label-add registry.data=true $NODE_ID

export EMAIL=mr.octavianz@gmail.com

export BASE_DOMAIN=yudhadhstr.my.id
export DOMAIN_TREAFIK=traefik.yudhadhstr.my.id
export DOMAIN_PORTAINER=portainer.yudhadhstr.my.id
export DOMAIN_REGISTRY=registry.yudhadhstr.my.id
export DOMAIN_SWARMPIT=swarmpit.yudhadhstr.my.id
export DOMAIN_REGISTRY_UI=registry-ui.yudhadhstr.my.id

export WORKDIR=$(pwd)
echo "workdir = ${WORKDIR}"

mkdir -p devops/traefik/cert

docker compose -f treafic.yml pull
docker compose -f portainer.yml pull
docker compose -f swarmpit.yml pull
docker compose -f registry.yml pull
docker stack deploy traefik -c treafic.yml
docker stack deploy portainer -c portainer.yml
docker stack deploy swarmpit -c swarmpit.yml
docker stack deploy registry -c registry.yml