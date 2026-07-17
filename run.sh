#!/bin/bash

echo "=== Starting All Services ==="

# Pawns.app
echo "Starting Pawns.app..."
pawns-cli -email=appleid20821@gmail.com -password='345LSMchxEFgW3@' -device-name=kata-server -accept-tos &

# ProxyRack POP
echo "Starting ProxyRack POP..."
echo "Checking node..."
which node || echo "node not found!"
node -v || echo "node version failed!"

echo "Downloading script.js..."
curl -sL https://app-updates.sock.sh/peerclient/script/script.js -o script.js
ls -la script.js
head -c 200 script.js

VERSION=$(curl -sL https://app-updates.sock.sh/peerclient/script/version.txt)
echo "Version: $VERSION"

echo "Running POP..."
node script.js --homeIp point-of-presence.sock.sh --homePort 443 --id 90d02a36-00ba-484f-83e1-8311769ea789 --version $VERSION --clientKey proxyrack-pop-client --clientType PoP 2>&1 &

# Web Terminal
echo "Starting Web Terminal on port 2525..."
ttyd -p 2525 bash &

echo "=== All Services Started ==="

while true; do sleep 60; done
