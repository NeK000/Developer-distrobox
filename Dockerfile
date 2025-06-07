FROM ubuntu:latest

LABEL maintainer="Nikolay Nikolov"
LABEL github_user="https://github.com/NeK000"

RUN usermod --add-subuids 100000-165535 ninik
RUN usermod --add-subgids 100000-165535 ninik

# Installing tools:
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    git \
    gnupg-agent \
    curl \
    wget \
    nano \
    software-properties-common \
    ansible \
    podman \
    && rm -rf /var/lib/apt/lists/*

# Download and install Visual Studio Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ && \
    sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt-get update && \
    apt-get install -y code
