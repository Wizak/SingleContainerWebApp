#! /bin/bash

export PROJECT_NAME="$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]')"

function show_commands() {
    echo "Available commands: '$1'"
    printf '\r\n'
    printf '    '
    printf '%s\n    ' "${commands[@]}"
    printf '\r\n'
}

function docker_compose() {
    local env_file=""

    if [ "$MODE" == "prod" ]; then
        env_file="--env-file .env.prod"
    elif [ "$MODE" == "stag" ]; then
        env_file="--env-file .env.stag"
    elif [ "$MODE" == "dev" ]; then
        env_file="--env-file .env.dev"
    fi

    docker-compose \
        --project-name $PROJECT_NAME \
        -f "docker-compose.base.yml" \
        -f "configs/docker-compose.$MODE.yml" \
        $env_file \
        $@
}

function logs() {
    docker_compose logs --follow $@
}

base_commands=(exec logs ash db docker_compose collect_backend_static create_app)
