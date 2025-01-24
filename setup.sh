#!/bin/bash
if [ -z "$BOT_TOKEN" ] || [ -z "$BOT_CHANNEL" ]
then
    echo "Discord integration bot secrets not found, will be left as-is or empty."
    if [ -f "./data/config/Discord-Integration.toml" ]
    then
        echo "Existing config file found, using."
        cp ./data/config/Discord-Integration.toml ./server-overrides/config/Discord-Integration.toml
    else
        echo "No existing file found, secretless file will be used"
        cp ./server-overrides/config/Discord-Integration_empty.toml ./server-overrides/config/Discord-Integration.toml
    fi
else
    cat <(head -n4 ./server-overrides/config/Discord-Integration_empty.toml) <(echo -e '\tbotToken = "'$BOT_TOKEN'"') <(echo -e '\tbotChannel = "'$BOT_CHANNEL'"') <(tail -n +5 ./server-overrides/config/Discord-Integration_empty.toml) > ./server-overrides/config/Discord-Integration.toml
fi
rm -rf ./data/.cache ./data/.fabric ./data/config ./data/datapacks ./data/DiscordIntegration-Data ./data/libraries ./data/mods ./data/versions ./data/.fabric-manifest.json ./data/.install-modrinth.env ./data/.modrinth-modpack-manifest.json ./data/.rcon-cli.env ./data/.rcon-cli.yaml ./data/eula.txt ./data/fabric-server-mc.* ./data/server.properties ./data/wip.mrpack
zip -r -0 ./data/wip.mrpack ./server-overrides ./modrinth.index.json
rm ./server-overrides/config/Discord-Integration.toml
docker compose up -d
if ! [ -f "./nginx/ssl/nginx-selfsigned.key" ]
then
    openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ./nginx/ssl/nginx-selfsigned.key -out ./nginx/ssl/nginx-selfsigned.crt -batch
fi
docker compose -f ./docker-compose-squaremap.yml up -d
docker attach wip-smp-mc-1