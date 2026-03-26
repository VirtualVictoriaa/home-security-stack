#!/bin/bash
echo "=== Docker Security Stack Diagnostic ==="
cd ~/docker-security

echo -e "\n1. Docker Compose Validation:"
docker compose config -q && echo "✓ Valid" || echo "✗ Invalid"

echo -e "\n2. Container Status:"
docker compose ps

echo -e "\n3. Pi-hole Configuration:"
docker exec pihole cat /etc/pihole/setupVars.conf 2>/dev/null | grep -i "password\|web" || echo "No config found"

echo -e "\n4. Network Connectivity:"
echo "Pi-hole container IP: $(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pihole)"
echo "Port 8080 status: $(netstat -tuln | grep :8080 | wc -l) listeners"

echo -e "\n5. Service Logs (last 5 lines each):"
echo "Pi-hole:"
docker compose logs pihole --tail=5 2>/dev/null
echo "Nginx Proxy Manager:"
docker compose logs nginx-proxy-manager --tail=5 2>/dev/null

echo -e "\n6. Web Interface Test:"
curl -s -o /dev/null -w "Pi-hole HTTP Status: %{http_code}\\n" http://192.168.0.134:8080/admin || echo "Pi-hole: Connection failed"

echo -e "\n=== Diagnostic Complete ==="
