FROM nginx:alpine as base


FROM base as dev
EXPOSE 80
COPY ./dev/nginx.conf.template /etc/nginx/templates/default.conf.template

FROM base as prod
EXPOSE 443
COPY ./prod/nginx.conf.template /etc/nginx/templates/default.conf.template
