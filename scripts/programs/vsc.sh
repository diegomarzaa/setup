#!/bin/bash

#TODO Falta acabar

echo "⌨️  Installing VSCode"
sudo apt update
sudo apt install -y code

function install {
  name="${1}"
  code --install-extension ${name} --force
}

install bierner.markdown-preview-github-styles
install ms-python.python
install yzhang.markdown-all-in-one