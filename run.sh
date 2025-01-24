#!/bin/bash
docker compose up -d
docker compose -f ./docker-compose-squaremap.yml up -d
docker attach wip-smp-mc-1