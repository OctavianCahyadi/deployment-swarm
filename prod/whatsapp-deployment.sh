#!/bin/sh


PASS=kucingITEM123
USER=anggun



docker login registry.yudhadhstr.my.id -u "$USER" -p "$PASS"
sleep 1

echo ""
echo "Getting latest for image repositories using pull "
echo -ne '\n'


echo "------------- Building docker-stack -------------"


export DOMAIN_API=whatsapp.yudhadhstr.my.id

docker compose -f whatsapp-deployment.yml pull && docker stack deploy whatsapp -c whatsapp-deployment.yml --with-registry-auth
echo -ne '\n'

docker logout registry.yudhadhstr.my.id
echo "------------- Docker running -------------"