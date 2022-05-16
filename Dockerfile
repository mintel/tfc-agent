FROM hashicorp/tfc-agent:1.2.0

USER root

RUN apt-get update && apt-get install -y \
  curl \
  git \
  unzip \
  zip \
  && rm -rf /var/lib/apt/lists/*

COPY install-binaries.sh .
RUN ./install-binaries.sh

USER tfc-agent
