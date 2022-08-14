#!/bin/bash
########################################################################
# Usage: APPID=736260 ./goldberg.sh	   			       #
# You need to set EMU_DIR to the extracted goldberg emulator directory.#
# To be able to use genconf get the scripts from the goldberg source   #
# code and put it in $EMU_DIR/scripts				       #
########################################################################

#config
EMU_DIR="/path/to/emu"

#funcitons
dlc() {
	#get games dlc list
	DLC_ID="$(curl -s https://store.steampowered.com/api/appdetails?appids="$APPID" | jq .[].data.dlc | sed 's|[^0-9]||g' | xargs)"

	#list all dlcs with names and put them into dlc.txt
	mkdir -p steam_settings
	echo "Getting DLC.txt for $APPID"
	for i in $DLC_ID
	do
		echo "getting info for $i" && echo "$i=$(curl -s https://store.steampowered.com/api/appdetails?appids="$i" | jq -r .[].data.name)" >> "steam_settings/DLC.txt"
	done

	echo "Getting DLC.txt for $APPID completed"   
}

username() {
	mkdir -p steam_settings
	echo "jc141" > steam_settings/force_account_name.txt
}

native() {
	mv libsteam_api.so libsteam_api.so.orig
	if file libsteam_api.so.orig | grep -q "32-bit";
	then
		cp "$EMU_DIR/linux/x86/libsteam_api.so" libsteam_api.so
	else
		cp "$EMU_DIR/linux/x86_64/libsteam_api.so" libsteam_api.so
	fi
}

windows() {
	if [ -e steam_api64.dll ];
	then
		mv steam_api64.dll steam_api64.dll.orig && cp "$EMU_DIR/experimental/steam_api64.dll" steam_api64.dll
	else
		mv steam_api.dll steam_api.dll.orig && cp "$EMU_DIR/experimental/steam_api.dll" steam_api.dll
	fi
}

interfaces() {
	if [ -e libsteam_api.so ];
	then
		"$EMU_DIR/linux/tools/find_interfaces.sh" libsteam_api.so >> steam_interfaces.txt
	else
		"$EMU_DIR/linux/tools/find_interfaces.sh" steam_api*.dll >> steam_interfaces.txt
	fi
}

genconf() {
	python "$EMU_DIR/scripts/generate_emu_config.py" $APPID && cp -r "$APPID"_output/steam_settings "$PWD" && rm -rf "$PWD/login_temp" && rm -rf "$PWD/backup" && rm -rf "$APPID"_output
}

if [ -e libsteam_api.so ];
then
	interfaces && native && username && dlc && genconf
else
	interfaces && windows && username && dlc && genconf
fi
