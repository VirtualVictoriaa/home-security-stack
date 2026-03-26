#!/bin/bash
set -e  # Exit on error

echo "=== Home Security Stack Setup ==="
cd ~/docker-security

# Stop any running containers
echo "Stopping existing containers..."
docker compose down 2>/dev/null || true

# Clean up Docker volumes
echo "Cleaning up volumes..."
sudo rm -rf pihole/ nginx-proxy-manager/

# Create directories
echo "Creating directories..."
mkdir -p pihole/{etc-pihole,etc-dnsmasq.d}
mkdir -p nginx-proxy-manager/{data,letsencrypt}

# Validate docker-compose.yml
echo "Validating docker-compose.yml..."
docker compose config -q

# Start services
echo "Starting services..."
docker compose up -d

# Wait for services to start
echo "Waiting for services to initialize..."
sleep 15

# Check service status
echo "=== Service Status ==="
docker compose ps

# Check Pi-hole logs for password info
echo -e "\n=== Pi-hole Logs (last 10 lines) ==="
docker compose logs pihole | tail -10

# Check Nginx Proxy Manager logs
echo -e "\n=== Nginx Proxy Manager Logs (last 5 lines) ==="
docker compose logs nginx-proxy-manager | tail -5

# Test web interfaces
echo -e "\n=== Web Interface Tests ==="
echo "Pi-hole: http://192.168.0.134:8080/admin"
echo "Password: pihole123"
echo "Nginx Proxy Manager: http://192.168.0.134:81"
echo "Default: admin@example.com / changeme"

echo -e "\n=== Network Tests ==="
echo "Testing Pi-hole DNS..."
nslookup google.com 192.168.0.134

echo -e "\n=== Setup Complete ==="
