#!/bin/bash

# https://www.pluralsight.com/cloud-guru/labs/aws/nginx-managing-ssl-certificates-using-openssl

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
echo "Nginx: setting up ssl ...";
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/ssl/certs/akaraca.crt \
	-keyout /etc/ssl/certs/akaraca.key \
	-subj "/C=TR/ST=Kocaeli/L=Istanbul/O=Ecole42/OU=akaraca/CN=akaraca"
echo "Nginx: ssl is set up!";
fi

exec "$@"