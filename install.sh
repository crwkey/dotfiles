#!/bin/bash

CONFIG_DIR="$HOME/.config"

if [ ! -d "$CONFIG_DIR" ]; then
    mkdir -p $HOME/.config/
fi

cd "$(dirname "$0")"

SCRIPT_DIR="$PWD"

echo "The script is located in: $SCRIPT_DIR"

ln -sf $SCRIPT_DIR/nvim $HOME/.config/

if [[ $(uname) == "Linux" ]]; then
    echo "Current OS is Linux"

elif [[ $(uname) == "Darwin" ]]; then
    echo "Current OS is macOS"
else
    echo "other os"
fi
