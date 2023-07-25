#!/bin/bash

docker run -it --rm \
    --volumes-from wordpress_wordpress_1 \
    --network container:wordpress_wordpress_1 \
    wordpress:cli "$@"
