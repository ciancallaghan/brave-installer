#!/bin/sh

set -e

if [ "$(id -u)" != 0 ]; then
	echo "Must be run as sudo/root."
	exit 1
fi

if ! hash curl ; then
	echo "Curl is required. Please install it."
	exit 1
elif ! hash wget; then
	echo "Wget is required. Please install it."
	exit 1
elif ! hash unzip; then
	echo "Unzip is required. Please install it."
	exit 1
fi

pkgbase=$(curl -s "https://api.github.com/repos/brave/brave-browser/releases/latest" | grep -e "linux" -e "amd64")
pkgname=$(echo "$pkgbase" | grep "name" | head -n 1 | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g')
pkgurl=$(echo "$pkgbase" | grep "download" | head -n 1 | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g')

wget "$pkgurl"
unzip -d "/opt/brave" "$pkgname"
cp ./brave-browser.desktop /usr/share/applications/brave-browser.desktop
ln -s /opt/brave/brave /usr/bin/brave
rm "$pkgname"
