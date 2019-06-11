FROM alpine

RUN apk --no-cache add curl openvpn

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s CMD curl -s 'https://ipinfo.io'

ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
