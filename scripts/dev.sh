#! /bin/bash

export MODE='dev'
export LOGS_DIR='supervisord-logs'

function init_build() {
    docker_compose build $@
}

function stop() {
    docker_compose down $@
}

function init_start() {
    sudo rm -rf $LOGS_DIR
    docker_compose up --build -d $@
}

function restart() {
    stop
    init_start
}

function rebuild() {
    init_start $@
}

dev_commands=(init_build init_start stop rebuild restart)

source scripts/base.sh

commands=("${base_commands[@]}" "${dev_commands[@]}")
if [[ $# -gt 0 ]] && [[ "${commands[@]}" =~ "$1" ]]; then
    $@;
else
    show_commands $MODE "$commands"
fi
