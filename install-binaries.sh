#!/usr/bin/bash
# Unfortunately due to the way that the agent works we are unable to use asdf so functions to install all additional 
# binaries required by the Terraform Cloud agent should be added here in the format "install_${APP_NAME}". App names and
# versions are pulled from the common .terraform-tools file at
# https://github.com/mintel/build-harness-extensions/blob/main/modules/satoshi/tf-tool-versions. If a function hasn't
# been written for an app in that file then the build will fail.

set -ex

# Install asdf
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf

# Install tools via asdf
grep -vP '(^terraform\s|\sterraform$)' tf-tool-versions > $HOME/.tool-versions
grep -E "^#asdf:" $HOME/.tool-versions | cut -d':' -f2- | tr '\n' '\0' | xargs -0 -n1 -Icmd -- sh -c '$HOME/.asdf/bin/asdf cmd'
$HOME/.asdf/bin/asdf install

# Create symlinks so the TFCloud agent still works
ln -sf $HOME/.asdf/shims/aws /usr/local/aws
ln -sf $HOME/.asdf/shims/terraform-docs /usr/local/terraform-docs
ln -sf $HOME/.asdf/shims/tflint /usr/local/tflint
ln -sf $HOME/.asdf/shims/tfsec /usr/local/tfsec
