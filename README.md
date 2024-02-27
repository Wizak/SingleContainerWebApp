# Multi-WebApp Docker Composition

## Overview
This project facilitates the deployment and management of multiple web applications within a Docker environment. Each application resides in its own, single container, organized within a Docker composition. The orchestration is handled by Docker Compose, allowing for the seamless coordination of services within each application.

## Features
- **Containerized Applications**: Each application is encapsulated within its own Docker container, promoting isolation and easy management.
- **Docker-in-Docker Setup**: Applications run within Docker containers, enabling efficient deployment and resource utilization.
- **Nginx Reverse Proxy**: Utilizes Nginx as a reverse proxy to efficiently route incoming requests to the respective applications.
- **Single Page Application (SPA) Design**: The primary goal is to offer a single page application experience, consolidating multiple web apps under one server and domain.
- **Unified Access Paths**: Applications are accessed through uniform paths under the domain, structured as `/portfolio/<app_name>`.
- **Configuration Flexibility**: Configuration for each application can be adjusted by modifying the `.env` files located at `/apps/<app_name>`.
- **Supervisord Integration**: Utilizes supervisord for managing the Docker daemon process and starting Docker Compose within each application container.

## Setup Instructions
1. Clone this repository to your local machine.
2. Navigate to the `apps` directory and place your application code within separate directories.
3. Configure each application's environment variables in the respective `.env` files located at `/apps/<app_name>`.
4. Ensure Docker is installed on your system.
5. Run the Multiple web apps using the provided scripts (dev or prod mode) into main directory: `bash ./scripts/dev.sh restart`.
6. Access your applications through the specified paths under the configured domain.

## Directory Structure
- **apps/**: Directory containing individual applications, each in its own subdirectory.
- *<app_name>*: Subdirectories for each application.
 - **.env**: Environment variables specific to the application.
 - *Application files...*
- **docker-compose.yaml**: Configuration file for orchestrating Docker containers.
- **scripts** dir: Builds and runs applications.
- *Other project files...*

## Dependencies
- Docker
- Docker Compose
- Nginx
- Supervisord
