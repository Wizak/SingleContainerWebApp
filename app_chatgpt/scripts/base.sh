#! /bin/bash

export PROJECT_NAME='chatgpt'

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

function exec() {
    docker_compose exec $@;
}

function db() {
    function init() {
        function superuser() {
            exec backend python manage.py createsuperuser $@
        }

        function manager() {
            exec backend python manage.py createmanager $@
        }

        commands=(superuser manager)
        if [[ $# -gt 0 ]] && [[ "${commands[@]}" =~ "$1" ]]; then
            $@;
        else
            show_commands "db init" "$commands"
        fi
    }

    # You can migrate to the specific migration version by commands:
    # show_migrations [app_name]
    # then copy number of migration that you need and run:
    # migrate [ app_name ] [migration_number]

    function show_migrations() {
        exec backend python manage.py showmigrations $@
    }

    function migrate() {
        exec backend python manage.py migrate $@
    }

    function commit() {
        exec backend python manage.py makemigrations $@
    }

    commands=(downgrade show_migrations migrate commit init)
    if [[ $# -gt 0 ]] && [[ "${commands[@]}" =~ "$1" ]]; then
        $@;
    else
        show_commands db "$commands"
    fi
}

function collect_backend_static() {
    exec backend python manage.py collectstatic $@
}

function ash() {
    if [[ $# -gt 0 ]]; then
        exec $1 ash;
    fi
}

function logs() {
    docker_compose logs --follow $@
}

base_commands=(exec logs ash db docker_compose collect_backend_static)
