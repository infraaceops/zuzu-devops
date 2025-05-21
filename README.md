# ZUZ Privacy Gateway Deployment

## Quick Start

1. Install Docker and Docker Compose.
2. Clone this repository.
3. Run `docker-compose up -d`.

## Access Information

- **Clearnet**: `http://<your-server-ip>`
- **Tor**: Check `./logs/tor.txt` for the `.onion` address.
- **I2P**: Check `./logs/i2p.txt` for the `.i2p` address.
- **IPFS**: Check `./logs/ipfs.txt` for the CID.

## Persistence

Data is stored in `./data` and logs in `./logs`. Backup these directories to retain configurations across deployments.