#!/bin/bash
#set game id
if [ -f steam_appid.txt ]
then
    GAME_ID=$(<steam_appid.txt)
else
    read -ep "game appid: " GAME_ID
    echo $GAME_ID > steam_appid.txt
fi
#get games dlc list
DLC_ID="$(curl -s https://store.steampowered.com/api/appdetails?appids="$GAME_ID" | jq .[].data.dlc | sed 's|[^0-9]||g' | xargs)"

#list all dlcs with names and put them into dlc.txt
mkdir -p steam_settings
echo "Getting DLC.txt for $GAME_ID"
for i in $DLC_ID
do
    echo "getting info for $i" && echo "$i=$(curl -s https://store.steampowered.com/api/appdetails?appids="$i" | jq -r .[].data.name)" >> "steam_settings/DLC.txt"
done

echo "Getting DLC.txt for $GAME_ID completed"