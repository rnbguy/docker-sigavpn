FROM alpine

RUN apk --update add curl openvpn

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s CMD curl -s 'https://ipinfo.io'

ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
