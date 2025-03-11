FROM hashicorp/tfc-agent:1.20

USER root

ARG DEBIAN_FRONTEND=noninteractive

# hadolint ignore=DL3008
RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends \
  curl \
  default-jre \
  git \
  openssl \
  pwgen \
  unzip \
  zip \
  && rm -rf /var/lib/apt/lists/*

USER tfc-agent


# Install tools via asdf (grabbing versions from build-harness-extensions)
WORKDIR /tmp
ADD --chown=tfc-agent https://raw.githubusercontent.com/mintel/build-harness-extensions/main/modules/satoshi/tf-tool-versions .
COPY install-binaries.sh .
RUN ./install-binaries.sh

WORKDIR /home/tfc-agent

# Set environment variables required for asdf-installed tools to function when used by the tfc-agent:
#   - PATH is required since the asdf bash plugin isn't installed, so we need to set where to find asdf's shims for the installed binaries
#   - ASDF_DATA_DIR is required since the agent overrides the HOME var to ensure a clean environment each run, which confuses asdf's shims
ENV PATH="/home/tfc-agent/.asdf/shims:$PATH" \
  ASDF_DATA_DIR="/home/tfc-agent/.asdf"
