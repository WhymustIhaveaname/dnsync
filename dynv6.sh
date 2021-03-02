#!/bin/sh -e
hostname=$1
device=$2

if [ -z "$hostname" -o -z "$token" ]; then
  echo "Usage: token=<your-authentication-token> [netmask=64] $0 your-name.dynv6.net [device]"
  exit 1
fi

if [ -z "$netmask" ]; then
  netmask=128
fi

if [ -n "$device" ]; then
  device="dev $device"
fi

if [ -e /usr/bin/curl ]; then
  bin="curl -fsS --connect-timeout 10"
#elif [ -e /usr/bin/wget ]; then
#  bin="wget -O-"
else
  echo "found curl failed"
  exit 1
fi

# send ipv4 addresses to dynv6
echo -n "--sending ipv4--"
$bin "https://ipv4.dynv6.com/api/update?hostname=$hostname&ipv4=auto&token=$token"

#address=$(ip -6 addr list scope global $device | grep -v " fd" | sed -n 's/.*inet6 \([0-9a-f:]\+\).*/\1/p' | head -n 1)
#if [ -z "$address" ]; then
#  echo -n "--no IPv6 address found--"
#  #$bin "https://ipv6.dynv6.com/api/update?hostname=$hostname&ipv6=auto&token=$token"
#else
#  echo -n "--sending ipv6--"
#  current=$address/$netmask
#  $bin "https://dynv6.com/api/update?hostname=$hostname&ipv6=$current&token=$token"
#fi
echo "--finish--"
