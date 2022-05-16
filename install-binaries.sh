#!/usr/bin/bash
# Unfortunately due to the way that the agent works we are unable to use asdf so functions to install all additional 
# binaries required by the Terraform Cloud agent should be added here in the format "install_${APP_NAME}". App names and
# versions are pulled from the common .terraform-tools file at
# https://github.com/mintel/build-harness-extensions/blob/main/modules/satoshi/tf-tool-versions. If a function hasn't
# been written for an app in that file then the build will fail.

set -ex

function install_awscli() {
  local version; version=$1
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${version}.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  ./aws/install
  rm awscliv2.zip
}

function install_terraform-docs() {
  local version; version=$1
  curl -Lo ./terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v${version}/terraform-docs-v${version}-$(uname)-amd64.tar.gz"
  tar -xzf terraform-docs.tar.gz
  chmod +x terraform-docs
  mv terraform-docs /usr/local/terraform-docs
  rm terraform-docs.tar.gz
}

function install_tflint() {
  local version; version=$1
  curl -s "https://raw.githubusercontent.com/terraform-linters/tflint/v${version}/install_linux.sh" | bash
}

function install_tfsec {
  local version; version=$1
  curl -Lo ./tfsec "https://github.com/aquasecurity/tfsec/releases/download/v${version}/tfsec-linux-amd64"
  chmod +x tfsec
  mv tfsec /usr/local/tfsec
}

curl -s https://raw.githubusercontent.com/mintel/build-harness-extensions/main/modules/satoshi/tf-tool-versions | grep -vP '(^terraform\s|\sterraform$)' | grep '^[A-Za-z]' > "$HOME/.tool-versions"
while read -r line; do
  app=$(echo "$line" | cut -d' ' -f1)
  version=$(echo "$line" | cut -d' ' -f2)
  func="install_${app}"
  if declare -f "$func"; then
    "$func" "$version"
  else
    echo "ERROR: Function not available to install $app"
    exit 1
  fi
done < "$HOME/.tool-versions"
