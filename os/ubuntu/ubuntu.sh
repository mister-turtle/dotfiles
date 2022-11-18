#!/usr/bin/env bash

set -e  # set fail on first error

pkgs="software-properties-common neovim shellcheck build-essential apt-transport-https tmux curl guake keepassxc tree"

function main
{
	apt update -y
	apt upgrade -y $pkgs
	install_vscode
}

function install_vscode
{

	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	rm packges.microsoft.gpg
	echo 'deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' > /etc/apt/sources.list.d/vscode.list

	apt update -y
	apt install -y code
}

main $@
