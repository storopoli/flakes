#!/bin/sh

vpn() {
	if curl -Ls am.i.mullvad.net/json | jq .mullvad_exit_ip; then
		icon=""
		class=on
	else
		icon=""
		class=off
	fi
	printf '{"text": " %s ", "class": "%s"}\n' "$icon" "$class"
}

if grep '^home-' /etc/hostname >/dev/null; then
	while true; do
		vpn
		sleep 5m
	done
fi
