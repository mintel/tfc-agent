#!/bin/bash

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch ${ASDF_VERSION}
echo '. $HOME/.asdf/asdf.sh' >> .bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> .bashrc
export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH"

wget -O $HOME/.tool-versions https://raw.githubusercontent.com/mintel/build-harness-extensions/main/modules/satoshi/tool-versions
mapfile -t asdf_cmds < <(grep -o "plugin add.*" .tool-versions)

for asdf_cmd in "${asdf_cmds[@]}"; do
  asdf $asdf_cmd
done
asdf install
