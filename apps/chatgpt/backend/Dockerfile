FROM python:3.12.1-alpine3.19 AS base

RUN apk update && \
    apk upgrade && \
    pip install --upgrade pip

# timezone setup
RUN apk add --no-cache tzdata

ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /backend

COPY ./entrypoint.sh /backend/entrypoint.sh
RUN chmod +x -R /backend/entrypoint.sh

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

EXPOSE 5000

FROM base as prod
ENTRYPOINT ["ash", "./entrypoint.sh", "prod"]

FROM base as dev
ENTRYPOINT ["ash", "./entrypoint.sh", "dev"]

