FROM debian:latest as builder

RUN apt update && apt install netbase

FROM puppet/puppetserver

COPY scripts/* /docker-entrypoint.d/

COPY --from="builder" /etc/ethertypes /etc/protocols /etc/rpc /etc/services /etc/
