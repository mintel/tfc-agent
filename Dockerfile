FROM hashicorp/tfc-agent:1.2.0

USER root

RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl \
  git \
  gnupg \
  lsb-release \
  && rm -rf /var/lib/apt/lists/*

# INSTALL AWSCLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# INSTALL DOCKER
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd docker && usermod -aG docker tfc-agent

USER tfc-agent
