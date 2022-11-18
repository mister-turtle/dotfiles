#!/usr/bin/env bash

set -e  # set fail on first error

pkgs="vim shellcheck"

function main
{
	dnf update --assumeyes
	dnf install --assumeyes $pkgs
	install_vscode
}

function install_vscode
{
	rpm --import https://packages.microsoft.com/keys/microsoft.asc
	cat <<EOF | tee /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

	dnf check-update --assumeyes
	dnf install --assumeyes code
}

main $@
