# Use the official Ubuntu base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install any dependencies you need
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Render requires a service to listen on a port
# This is a dummy command to keep the container alive and listening
CMD ["sh", "-c", "echo 'Ubuntu container started' && tail -f /dev/null"]
