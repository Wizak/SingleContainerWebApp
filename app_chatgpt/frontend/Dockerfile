FROM node:20.11.0-alpine3.19 AS base

FROM base AS builder
WORKDIR /frontend
COPY . .
RUN yarn install
RUN yarn build

FROM alpine:latest AS prod
COPY --from=builder /frontend/build/. /frontend/

FROM base AS dev
WORKDIR /frontend
COPY package.json ./
COPY yarn.lock ./
CMD yarn && yarn start
