FROM node:20-slim

# Встановлення необхідних пакетів
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    gnupg \
    make \
    && rm -rf /var/lib/apt/lists/*

# Встановлення Docker CLI
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

# Встановлення Claude CLI
RUN npm install -g @anthropic-ai/claude-code

# Створення користувача з правильними правами
RUN useradd -u 1000 -g 1000 -ms /bin/bash deo
RUN usermod -aG docker deo

WORKDIR /workspace
RUN chown -R 1000:1000 /workspace

USER deo

ENTRYPOINT ["claude"]
CMD []
