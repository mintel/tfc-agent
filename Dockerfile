FROM hashicorp/tfc-agent:1.2.0

ENV ASDF_VERSION=v0.10.0

USER root

RUN apt-get update && apt-get install -y \
  curl \
  git \
  && rm -rf /var/lib/apt/lists/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

USER tfc-agent


# ENV HOME="/home/tfc-agent"
# ENV ASDF_DIR="$HOME/.asdf"
# ENV PATH="$ASDF_DIR/shims:$ASDF_DIR/bin:$PATH"
# COPY asdf-install.sh .
# RUN ./asdf-install.sh

# COPY docker-entrypoint.sh .
# ENTRYPOINT [ "./docker-entrypoint.sh" ]
