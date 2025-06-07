FROM ubuntu:latest

LABEL maintainer="Nikolay Nikolov"
LABEL github_user="https://github.com/NeK000"

# Create user ninik with UID/GID 1000 (matching your host)
RUN groupadd -g 1000 ninik && \
    useradd -m -u 1000 -g 1000 ninik

# Install packages
RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    git \
    gnupg-agent \
    curl \
    wget \
    nano \
    ansible \
    podman \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Add ninik to sudoers
RUN echo "ninik ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ninik

# Optional: VS Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/packages.microsoft.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list && \
    apt-get update && \
    apt-get install -y code

# Set default user and working directory
USER ninik
WORKDIR /home/ninik
