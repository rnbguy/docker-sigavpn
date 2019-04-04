#!/bin/sh

if [ -z $1 ]; then
  COUNTRY=netherlands2
else
  COUNTRY=$1
fi

echo SigaVPN country: ${COUNTRY}

sigavpn_link="https://ovpn.sigavpn.com/${COUNTRY}.php"

sigavpn_ip=`curl -sI ${sigavpn_link} | grep "^Location:" | grep -oE "\d+\.\d+\.\d+\.\d+"`

echo SigaVPN IP: ${sigavpn_ip}

curl -sL ${sigavpn_link} -o sigavpn.ovpn

echo Setting up OpenVPN..

openvpn --config sigavpn.ovpn > sigavpn.log &

while true; do
  ip=`curl -s http://ipinfo.io/ip`
  if [ ${ip} == ${sigavpn_ip} ]; then
    break
  fi
  sleep 1
done

echo Connected to SigaVPN.

tail -f /dev/null
