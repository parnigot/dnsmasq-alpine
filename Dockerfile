FROM alpine:3.15.0

LABEL maintainer "parnigot@gmail.com"

RUN apk --no-cache add dnsmasq \
	&& mkdir /var/lib/dnsmasq/

ENTRYPOINT ["/bin/sh"]