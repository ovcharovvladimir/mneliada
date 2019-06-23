FROM ubuntu:latest AS build

ENV TZ=EU/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV           NODE_ENV=development
ENV           WORKDIR=/home/blockchain/mainnet
WORKDIR       $WORKDIR

RUN apt-get update && apt-get -y install tzdata supervisor

COPY _build/ $WORKDIR
COPY _opam/  $WORKDIR/_opam
COPY config/* $WORKDIR/config/
COPY config/demo_supervisor.conf /etc/supervisor/conf.d/

EXPOSE 3000

CMD ["/usr/bin/supervisord"]
