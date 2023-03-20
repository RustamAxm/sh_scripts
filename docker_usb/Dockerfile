FROM ubuntu:20.04

LABEL maintainer="Rustam Akhmadullin"

USER root

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y iputils-ping

CMD ["./vhusbdarm"]
