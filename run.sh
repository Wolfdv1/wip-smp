#!/bin/bash
docker compose up -d
docker start squaremap || docker run --name squaremap -v ./data/squaremap/web:/usr/share/nginx/html:ro -d -p 80:80 nginx
docker attach wip-smp-mc-1