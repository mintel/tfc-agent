FROM hashicorp/tfc-agent:1.2.0

USER root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y \
  curl \
  default-jre \
  git \
  openssl \
  pwgen \
  unzip \
  zip \
  && rm -rf /var/lib/apt/lists/*

USER tfc-agent
ENV PATH="/home/tfc-agent/.asdf/shims:$PATH" \
    ASDF_DATA_DIR="/home/tfc-agent/.asdf"

ADD --chown=tfc-agent https://raw.githubusercontent.com/mintel/build-harness-extensions/main/modules/satoshi/tf-tool-versions .
COPY install-binaries.sh .
RUN ./install-binaries.sh

