# Home Security Stack

Home network security stack running on Raspberry Pi 4 with Docker.

## Services

- **Pi-hole** - DNS ad/tracker blocking
- **Nginx Proxy Manager** - HTTPS reverse proxy
- **Grafana** - Metrics dashboard
- **Portainer** - Docker management
- **Uptime Kuma** - Service monitoring

## Setup

1. Clone this repository
2. Copy `docker-compose.template.yml` to `docker-compose.yml`
3. Replace placeholder passwords with secure ones
4. Run `docker compose up -d`

## Access URLs

- Pi-hole: `https://pihole.lucifer.local/admin`
- Nginx Proxy Manager: `https://lucifer.local:81`
- Grafana: `https://grafana.lucifer.local`
- Portainer: `https://portainer.lucifer.local`

## Network Configuration

- Pi static IP: `192.168.0.134`
- Domain: `lucifer.local`
