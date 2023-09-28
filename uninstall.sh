#!/bin/sh

set -e

if [ "$(id -u)" != 0 ]; then
	printf "Must be run as sudo/root.\n"
	exit 1
fi

rm -r /opt/brave
rm /usr/share/applications/brave-browser.desktop
rm /usr/bin/brave
