#!/usr/bin/env bash

set -e

apt update -y
apt install -y ca-certificates curl gnupg lsb-release
apt remove -y docker docker-engine docker.io containerd runc

[[ ! -d "/etc/apt/keyrings" ]] && mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update -y 
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
