FROM hashicorp/tfc-agent:1.2.0

ENV ASDF_VERSION=v0.10.0

USER root

RUN apt-get update && apt-get install -y \
  curl \
  git \
  && rm -rf /var/lib/apt/lists/*

USER tfc-agent

ENV HOME="/home/tfc-agent"
ENV PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH"
COPY asdf-install.sh .
RUN ./asdf-install.sh
