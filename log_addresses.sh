#!/bin/bash

# Wait for Tor hidden service hostname
until [ -f /data/tor/hidden_service/hostname ]; do
    sleep 1
done
cp /data/tor/hidden_service/hostname /logs/tor.txt

# Generate I2P address from keys
until [ -f /data/i2pd/zuz.keys ]; do
    sleep 1
done
i2pd-tools keyinfo /data/i2pd/zuz.keys | grep -o '[[:alnum:]]\+\.b32\.i2p' | head -1 > /logs/i2p.txt

# Wait for IPFS to be ready and add site
until ipfs id >/dev/null 2>&1; do
    sleep 1
done
CID=$(ipfs add -Qr /site)
echo $CID > /data/ipfs/site.cid
ipfs pin add $CID
echo $CID > /logs/ipfs.txt

# Print banner
echo "[ZUZ Node Started]"
echo "Clearnet:  http://$(hostname -I | awk '{print $1}')"
echo "Tor:       http://$(cat /logs/tor.txt)"
echo "I2P:       http://$(cat /logs/i2p.txt)"
echo "IPFS:      ipfs://$(cat /logs/ipfs.txt)"

exit 0