#!/bin/bash
set -e

echo "=== Home Security Stack Setup ==="
cd ~/docker-security

# Stop and clean up
echo "Stopping existing containers..."
docker compose down --remove-orphans 2>/dev/null || true

# Clean up volumes
echo "Cleaning up volumes..."
sudo rm -rf pihole/ nginx-proxy-manager/ 2>/dev/null || true

# Create directories
echo "Creating directories..."
mkdir -p pihole/{etc-pihole,etc-dnsmasq.d}
mkdir -p nginx-proxy-manager/{data,letsencrypt}

# Create Pi-hole config with password
echo "Configuring Pi-hole..."
cat > pihole/etc-pihole/setupVars.conf << 'CONFIG'
WEBPASSWORD=7069686f6c65313233
PIHOLE_INTERFACE=eth0
IPV4_ADDRESS=192.168.0.134
PIHOLE_DNS_1=1.1.1.1
PIHOLE_DNS_2=1.0.0.1
QUERY_LOGGING=true
INSTALL_WEB=true
CONFIG

# Validate and start
echo "Validating docker-compose.yml..."
docker compose config -q

echo "Starting services..."
docker compose up -d

# Wait and test
echo "Waiting for services..."
sleep 15

echo "=== Final Test ==="
echo "Pi-hole: http://192.168.0.134:8080/admin/"
echo "Password: pihole123"
echo "Testing access..."
curl -s -o /dev/null -w "Pi-hole Status: %{http_code}\n" http://192.168.0.134:8080/admin/

echo "=== Setup Complete ==="
