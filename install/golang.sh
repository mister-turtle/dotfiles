#!/usr/bin/env bash

set -e  # set exit on first error

GO_VERSION="$( curl 'https://go.dev/VERSION?m=text' 2> /dev/null )"
[[ -z "${GO_VERSION}" ]] && { echo "couldnt determine Go version"; exit 1; }

GO_FILENAME="${GO_VERSION}.linux-amd64.tar.gz"

echo "installing ${GO_FILENAME}"

wget -O "/tmp/${GO_FILENAME}" "https://go.dev/dl/${GO_FILENAME}"
rm -rf /usr/local/go 2> /dev/null
tar -C /usr/local -xzf /tmp/${GO_FILENAME}
