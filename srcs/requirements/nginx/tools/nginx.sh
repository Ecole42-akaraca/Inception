#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-18-04

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
echo "Nginx: setting up ssl ...";
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/ssl/certs/nginx.crt \
	-keyout /etc/ssl/certs/nginx.key \
	-subj "/C=TR/ST=Kocaeli/L=Istanbul/O=Ecole42/OU=akaraca/CN=akaraca"
echo "Nginx: ssl is set up!";
fi

exec "$@"