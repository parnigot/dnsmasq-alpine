FROM alpine:3.15.0

LABEL maintainer "parnigot@gmail.com"

VOLUME /var/lib/dnsmasq

RUN apk --no-cache add dnsmasq

ENTRYPOINT [ "/usr/sbin/dnsmasq", "-C", "/etc/dnsmasq.conf", "--keep-in-foreground", "--log-facility", "-", "--dhcp-leasefile", "/var/lib/dnsmasq/dhcp.leases"]