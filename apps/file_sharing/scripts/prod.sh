#! /bin/bash

export MODE='prod'

function init_build() {
    docker_compose build $@
}

function init_start() {
    docker_compose up --build -d $@
}

function stop() {
    docker_compose down $@
}

function rebuild() {
    init_build backend
    init_build $@
}

function restart() {
    docker_compose down --volumes --remove-orphans
    docker image prune --force
    docker_compose up -d
}

function init_certs() {
    source .env.prod
    docker_compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ --cert-name certs -d $SERVER_HOST_DOMAIN -v $@
}

function init_certs_test() {
    init_certs --dry-run
}

function renew_certs() {
    stop
    docker_compose run --rm certbot renew
    restart
}

prod_commands=(init_build init_start stop rebuild restart
               init_certs init_certs_test renew_certs)

source scripts/base.sh

commands=("${base_commands[@]}" "${prod_commands[@]}")
if [[ $# -gt 0 ]] && [[ "${commands[@]}" =~ "$1" ]]; then
    $@;
else
    show_commands $MODE "$commands"
fi