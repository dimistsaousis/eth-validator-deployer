#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Check if jwtsecret file exists, if not, create it
if [ ! -f jwtsecret ]; then
    echo "Creating jwtsecret file..."
    openssl rand -hex 32 | tr -d "\n" | sudo tee /secrets/jwtsecret
fi

# Update the package database
apt update

# Install required dependencies
apt install -y apt-transport-https ca-certificates curl software-properties-common

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
    # Install Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
    apt update
    apt install -y docker-ce docker-ce-cli containerd.io

    # Start and enable Docker service
    systemctl start docker
    systemctl enable docker
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &>/dev/null; then
    # Install Docker Compose
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# Verify installations
docker --version
docker-compose --version

docker-compose build

# Remove jwtsecret
rm jwtsecret