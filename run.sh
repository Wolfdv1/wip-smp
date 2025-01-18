#!/bin/bash
if [ -z "$BOT_TOKEN" ]
then
echo "Discord integration bot token not set, token will be left as-is"
fi
if [ -z "$BOT_CHANNEL" ] 
then
echo "Discord integration channel ID not set, channel will be left as-is"
fi
cat <(head -n4 ./server-overrides/config/Discord-Integration_empty.toml) <(echo -e '\tbotToken = "'$BOT_TOKEN'"') <(echo -e '\tbotChannel = "'$BOT_CHANNEL'"') <(tail -n +5 ./server-overrides/config/Discord-Integration_empty.toml) > ./server-overrides/config/Discord-Integration.toml
rm ./server-overrides/config/Discord-Integration_empty.toml
zip -r -0 ./data/wip.mrpack ./server-overrides ./modrinth.index.json
docker compose up -d
docker attach wip-smp-mc-1