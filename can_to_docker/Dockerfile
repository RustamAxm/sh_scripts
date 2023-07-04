FROM ubuntu:22.04

WORKDIR /app
COPY . /app

RUN apt update && apt install -y iproute2 can-utils


ENTRYPOINT ["/bin/bash"]
