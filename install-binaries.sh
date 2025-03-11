#!/usr/bin/bash
# Tool versions are pulled at build time from https://github.com/mintel/build-harness-extensions/blob/main/modules/satoshi/tf-tool-versions

set -ex

# Install asdf
git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.15.0

# Install tools via asdf
grep -vP '(^terraform\s|\sterraform$)' tf-tool-versions > "$HOME/.tool-versions"
# shellcheck disable=SC2016
grep -E "^#asdf:" "$HOME/.tool-versions" | cut -d':' -f2- | tr '\n' '\0' | xargs -0 -n1 -Icmd -- sh -c '$HOME/.asdf/bin/asdf cmd'
"$HOME/.asdf/bin/asdf" install

# For backwards compatibility:
"$HOME/.asdf/bin/asdf" install awscli 2.11.8
"$HOME/.asdf/bin/asdf" install terraform-docs 0.16.0
"$HOME/.asdf/bin/asdf" install tflint 0.34.1
"$HOME/.asdf/bin/asdf" install tfsec 1.15.4
