FROM alpine:3.15.4

LABEL maintainer "parnigot@gmail.com"

RUN apk --no-cache add dnsmasq

ENTRYPOINT ["/usr/sbin/dnsmasq", "--conf-file=/etc/dnsmasq.conf", "--dhcp-leasefile=/var/lib/dnsmasq/dnsmasq.leases", "--keep-in-foreground", "--log-facility=-"]
