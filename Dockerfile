FROM hashicorp/tfc-agent:1.1

USER root

RUN apt-get update && apt-get install -y \
  curl \
  git \
  && rm -rf /var/lib/apt/lists/*

USER tfc-agent

ENV ASDF_VERSION=v0.9.0
COPY asdf-install.sh .
RUN ./asdf-install.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
