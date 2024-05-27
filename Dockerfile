FROM alpine:latest AS build

WORKDIR /usr/app

RUN apk add --update hugo bash npm git make openssh-client diffutils go
RUN npm install wrangler@latest

RUN git config --global user.name "Automated Deployment Process"
RUN git config --global user.email "deploy@kmcd.com"

COPY * /usr/app
