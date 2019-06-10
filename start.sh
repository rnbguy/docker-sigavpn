#!/bin/sh

if [ -z $CODE ]; then
  CODE=nl1
fi

echo SigaVPN code: ${CODE}

sigavpn_link="https://ovpn.sigavpn.com/${CODE}.php"

curl -sL ${sigavpn_link} -o sigavpn.ovpn

sigavpn_ip=`grep -E '^remote \d+.\d+.\d+.\d+' sigavpn.ovpn | head -n1 | cut -d' ' -f2`

echo SigaVPN IP: ${sigavpn_ip}

echo Setting up OpenVPN..

openvpn --config sigavpn.ovpn > sigavpn.log &

sleep 3

while true; do
  ip=`curl -s http://ipinfo.io/ip`
  if [ ${ip} == ${sigavpn_ip} ]; then
    break
  fi
  sleep 1
done

echo Connected to SigaVPN.

tail -f /dev/null
