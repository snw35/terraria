FROM debian:buster-20220125-slim

WORKDIR /opt

ENV TERRARIA_VERSION 1432
ENV TERRARIA_URL https://terraria.org/api/download/pc-dedicated-server
ENV TERRARIA_FILENAME terraria-server-${TERRARIA_VERSION}.zip
ENV TERRARIA_SHA256 fce0a54133bd881450937893bd86e31b570289c288061fb28b6385a6eac9c7c5

RUN apt-get update \
  && apt-get install -y \
    apt-utils \
    dialog \
    unzip \
    wget \
  && wget $TERRARIA_URL/$TERRARIA_FILENAME \
  && echo "$TERRARIA_SHA256  ./$TERRARIA_FILENAME" | sha256sum -c - \
  && unzip ./$TERRARIA_FILENAME \
  && rm -f ./$TERRARIA_FILENAME \
  && mv ./$TERRARIA_VERSION/Linux ./terraria \
  && rm -rf ./$TERRARIA_VERSION \
  && chmod +x /opt/terraria/TerrariaServer* \
  && rm -rf /var/lib/apt/lists/*

ENV CONFD_VERSION 0.16.0
ENV CONFD_URL https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION
ENV CONFD_FILENAME confd-$CONFD_VERSION-linux-amd64
ENV CONFD_SHA256 255d2559f3824dd64df059bdc533fd6b697c070db603c76aaf8d1d5e6b0cc334

RUN wget $CONFD_URL/$CONFD_FILENAME \
  && echo "$CONFD_SHA256  ./$CONFD_FILENAME" | sha256sum -c - \
  && mv ./$CONFD_FILENAME /usr/bin/confd \
  && chmod +x /usr/bin/confd \
  && mkdir -p /etc/confd/conf.d \
  && mkdir -p /etc/confd/templates

COPY serverconfig.txt.tmpl /etc/confd/templates/serverconfig.txt.tmpl
COPY terraria.toml /etc/confd/conf.d/terraria.toml
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV PATH="/opt/terraria:${PATH}"

WORKDIR /data
VOLUME /data

ENTRYPOINT ["/entrypoint.sh"]

CMD ["TerrariaServer"]
