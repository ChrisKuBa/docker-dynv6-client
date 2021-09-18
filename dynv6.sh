#!/bin/ash
while true
do 
	external_ipv6=`ip -6 a list "$INTERFACE" | grep -F "$GREP" | grep -Fv "inet6 fd00" | sed -r "s/.*inet6 (.*) scope .*/\1/"`
	url="http://dynv6.com/api/update?hostname=$ZONE&token=$TOKEN&ipv6=$external_ipv6"
	printf "request $url\n"
	curl "$url"
	printf "\n"
	sleep $SLEEP
done
