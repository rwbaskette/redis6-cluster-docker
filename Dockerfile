FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

# Set a master password for the redis instace
ENV REDIS_PASSWORD=

# Expose Redis ports
EXPOSE 6001 6002 6003 6004 6005 6006

# Install dependencies needed for building Redis
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    tcl \
    make \
    gcc \
    curl \
    libc6 \
    gettext-base \
    procps \
    psmisc

# Set working directory
WORKDIR /app

# Download Redis 6.2.17 source code
RUN curl -L https://download.redis.io/releases/redis-6.2.17.tar.gz | tar xz

# Build Redis
WORKDIR /app/redis-6.2.17
RUN make -j 4

# Install Redis (copy binaries to /usr/local/bin)
RUN make install

# Clean up build files
WORKDIR /app

# Copy startup scripts
COPY redis-cli.sh .
RUN chmod +x redis-cli.sh

# Copy startup scripts
COPY create-cluster.sh .
RUN chmod +x create-cluster.sh

COPY start.sh .
RUN chmod +x start.sh

# Entrypoint to run the startup script
ENTRYPOINT ["./start.sh"]

# ... for debugging
# ENTRYPOINT ["bash"]
# CMD ["-c", "while true; do echo 'Running...'; sleep 10; done"]
