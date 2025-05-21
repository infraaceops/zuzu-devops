# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    nginx \
    i2pd \
    tor \
    kubo \
    supervisor \
    i2pd-tools \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p \
    /site \
    /data/i2pd \
    /data/tor/hidden_service \
    /data/ipfs \
    /config \
    /logs

# Copy static site (placeholder index.html)
COPY ./site /site

# Configure Nginx
COPY ./nginx.conf /etc/nginx/conf.d/zuz.conf
RUN rm -f /etc/nginx/sites-enabled/default

# Configure i2pd tunnels
COPY ./i2pd/tunnels.conf /etc/i2pd/tunnels.conf

# Configure Tor
COPY ./tor/torrc /etc/tor/torrc

# Configure Supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/zuz.conf

# Copy log address script and set permissions
COPY ./log_addresses.sh /usr/local/bin/log_addresses.sh
RUN chmod +x /usr/local/bin/log_addresses.sh

# Expose HTTP port
EXPOSE 80

# Start supervisord
CMD ["/usr/bin/supervisord"]