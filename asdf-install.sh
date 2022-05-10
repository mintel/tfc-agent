#!/bin/bash
# We want to store the $HOME variable key in .bashrc rather than dereference it
# shellcheck disable=SC2016

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$ASDF_VERSION"
echo '. $HOME/.asdf/asdf.sh' >> .bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> .bashrc
export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH"

curl https://raw.githubusercontent.com/mintel/build-harness-extensions/main/modules/satoshi/tf-tool-versions | grep -vP '(^terraform\s|\sterraform$)' > "$HOME/.tool-versions"
mapfile -t plugin_cmds < <(grep -o "plugin add.*" "$HOME/.tool-versions")

for plugin_cmd in "${plugin_cmds[@]}"; do
  # We want word splitting to occur here (each word is an argument to the asdf command)
  # shellcheck disable=SC2086
  asdf $plugin_cmd
done
asdf install
