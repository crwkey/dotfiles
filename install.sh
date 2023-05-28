#!/bin/bash

CONFIG_DIR="$HOME/.config"

if [ ! -d "$CONFIG_DIR" ]; then
    mkdir -p $HOME/.config/
fi

cd "$(dirname "$0")"

SCRIPT_DIR="$PWD"

echo "The script is located in: $SCRIPT_DIR"

ln -sf $SCRIPT_DIR/nvim $HOME/.config/


isLinux=0
isMacOS=0

if [[ $(uname) == "Linux" ]]; then
    echo "Current OS is Linux"
    isLinux=1
elif [[ $(uname) == "Darwin" ]]; then
    echo "Current OS is macOS"
    isMacOS=1
else
    echo "other os"
fi

function installNvim() {
    if command -v nvim > /dev/null 2>&1; then
        echo "nvim is installed."
    else
        echo "nvim is not installed."
        if [ "$isLinux" -eq 1 ]; then

            if [[ $EUID -ne 0 ]]; then
                echo "This script must be run as root or with sudo"
                exit 1
            fi
            # install nvim
            yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
            yum install -y neovim python3-neovim
        fi

        if [ "$isMacOS" -eq 1] ; then
            brew install nvim
        fi
    fi

    profile_bashrc=~/.bashrc
    profile_zshrc=~/.zshrc

    if [ -e ${profile_zshrc} ]; then
        profile=${profile_bashrc}
        echo "zshrc exists"
    elif [ -e ${profile_bashrc} ]; then 
        profile=${profile_bashrc}
        echo "bashrc exists"
    else
        echo "no profile"
    fi

    if [ -f $profile ]; then
        . $profile
    fi

    # add alias
    if ! grep -q "alias vim=nvim" $profile; then
       echo "alias vim=nvim"  >> $profile 
    fi
}

# install nvim
installNvim


echo "script installed"
