FROM ubuntu:22.04

WORKDIR /app
COPY . /app

RUN apt update && apt install -y iproute2 can-utils libsocketcan-dev libconfig++-dev  


ENTRYPOINT ["./stw-dsua-sim_run"]
