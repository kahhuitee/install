#/bin/bash

# Docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# VS code
wget -O /tmp/vscode.deb https://vscode.download.prss.microsoft.com/dbazure/download/stable/fabdb6a30b49f79a7aba0f2ad9df9b399473380f/code_1.96.2-1734607745_amd64.deb
sudo dpkg -i /tmp/vscode.deb

# libmongocrypt
sudo sh -c 'curl -s --location https://pgp.mongodb.com/libmongocrypt.asc | gpg --dearmor >/etc/apt/trusted.gpg.d/libmongocrypt.gpg'
echo "deb https://libmongocrypt.s3.amazonaws.com/apt/ubuntu focal/libmongocrypt/1.12 universe" | sudo tee /etc/apt/sources.list.d/libmongocrypt.list
sudo apt-get update
sudo apt-get install -y libmongocrypt-dev
