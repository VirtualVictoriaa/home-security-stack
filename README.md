# Home Security Stack

## Current Status: ✅ Pi-hole DNS Operational
- Pi-hole running with host networking
- DNS working network-wide
- Web interface accessible
- Ready for additional services

## Services
- **Pi-hole**: DNS ad-blocking (`http://192.168.0.134/admin/`)
- **Nginx Proxy Manager**: Reverse proxy (`http://192.168.0.134:81/`)

## Next Steps
1. Add monitoring (Grafana + Prometheus)
2. Add Docker management (Portainer)
3. Add service monitoring (Uptime Kuma)

## Access URLs (Local Network)
- Pi-hole: `http://192.168.0.134/admin/`
- NPM: `http://192.168.0.134:81/`

## Remote Access
Via Tailscale MagicDNS using custom domains.
