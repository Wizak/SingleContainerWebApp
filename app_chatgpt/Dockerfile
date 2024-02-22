FROM ubuntu:latest


# Install prerequisites
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    supervisor \
    && rm -rf /var/lib/apt/lists/*


# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh


# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose


# Set working directory
USER root
WORKDIR /app_chatgpt
COPY . /app_chatgpt/


# Expose ports in container
EXPOSE 80
EXPOSE 443
EXPOSE 3000
EXPOSE 5000
EXPOSE 5432


# Start supervisord programs script
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ENTRYPOINT ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
