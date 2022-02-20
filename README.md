# dnsmasq-alpine

Simple container image based off Alpine with dnsmasq.
Used on my home network on a raspberry pi with podman on a CNI bridge network.

## Usage

Create a configuration file like for example:

```bash
mkdir /etc/dnsmasq-podman
cat > /etc/dnsmasq-podman/dnsmasq.conf << EOF
port=0
domain=example.org
dhcp-range=10.0.0.100,10.0.0.149,4h
dhcp-option=option:router,10.0.0.1
dhcp-option=option:dns-server,10.0.0.2,10.0.0.3
log-dhcp
EOF
```

Create a volume for the DHCP lease file

```bash
podman volume create dnsmasq-podman-leasefile
```

Run the container:

```bash
podman run -it --rm \
	--name dnsmasq-podman \
	--network cni-bridge \
	--ip 10.0.0.4 \
	--cap-add=NET_ADMIN,NET_RAW \
	-v /etc/dnsmasq-podman/dnsmasq.conf:/etc/dnsmasq.conf:Z \
	-v dnsmasq_podman_leasefile:/var/lib/dnsmasq:Z \
	ghcr.io/parnigot/dnsmasq-alpine:latest
```

Keep in mind:

1. Being a "low-level" service dnsmasq requires a lot of network permissions and direct access to the network
2. You must bind-mount the configuration file at `/etc/dnsmasq.conf` in the container
3. You must bind-mount the lease file volume at `/var/lib/dnsmasq` in the container
