#!/bin/sh

show_modes() {
    echo "Available modes: '$1'"
    printf '\r\n'
    printf '    '
    for mode in "${modes[@]}"; do
        printf '%s\n    ' "$mode"
    done
    printf '\r\n'
}

migrate() {
    python manage.py migrate --no-input
}

dev() {
    migrate
    python manage.py runserver 0.0.0.0:5000
}


prod() {
    migrate
    python manage.py collectstatic --no-input
    gunicorn scop.wsgi:application --bind 0.0.0.0:5000
}

MODE=$1

# Note: POSIX-compliant array declaration
modes="dev prod"

if [ $# -gt 0 ] && echo "$modes" | grep -wq "$MODE"; then
    "$@"
else
    show_modes "$modes"
fi
