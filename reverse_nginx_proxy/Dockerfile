FROM nginx:alpine as base


FROM base as dev
EXPOSE 80
COPY ./dev/nginx.conf /etc/nginx/conf.d/default.conf


FROM base as prod
EXPOSE 443
COPY ./prod/nginx.conf /etc/nginx/conf.d/default.conf
