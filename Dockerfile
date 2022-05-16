FROM hashicorp/tfc-agent:1.2.0

USER root

RUN apt-get update && apt-get install -y \
  curl \
  git \
  unzip \
  && rm -rf /var/lib/apt/lists/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm awscliv2.zip

USER tfc-agent
