#/bin/bash

# commons
sudo apt-get update
sudo apt install -y wget curl nano vim build-essential pkg-config openvpn terminator

# Docker
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
newgrp docker

# VS code
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders

# libmongocrypt
sudo sh -c 'curl -s --location https://pgp.mongodb.com/libmongocrypt.asc | gpg --dearmor >/etc/apt/trusted.gpg.d/libmongocrypt.gpg'
echo "deb https://libmongocrypt.s3.amazonaws.com/apt/ubuntu jammy/libmongocrypt/1.12 universe" | sudo tee /etc/apt/sources.list.d/libmongocrypt.list
sudo apt-get update
sudo apt-get install -y libmongocrypt-dev

# chrome
wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/chrome.deb

# postman
wget -O /tmp/postman.tar.gz https://dl.pstmn.io/download/latest/linux_64?deviceId=6b62fb7b-6c9f-476d-b903-4a223cde8ffb
sudo tar -xzf /tmp/postman.tar.gz -C /usr/local/lib
sudo ln -s /usr/local/lib/Postman/Postman /usr/bin/postman
sudo bash -c 'cat <<EOF > /usr/share/applications/postman.desktop
[Desktop Entry]
Name=Postman
Exec=/usr/bin/postman
Icon=/usr/local/lib/Postman/app/resources/app/assets/icon.png
Type=Application
Categories=Development;
Terminal=false
EOF'

# nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# jdk17
wget -O /tmp/java17.deb https://download.oracle.com/java/17/archive/jdk-17.0.12_linux-x64_bin.deb
sudo dpkg -i /tmp/java17.deb

# python3
sudo apt-get install -y python3
sudo ln -s $(which python3) /usr/bin/python

# golang
wget --no-check-certificate -O /tmp/golang.tar.gz https://golang.org/dl/go1.22.10.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf /tmp/golang.tar.gz

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

# insomnia
curl -1sLf \
  'https://packages.konghq.com/public/insomnia/setup.deb.sh' \
  | sudo -E distro=ubuntu codename=focal bash
sudo apt-get update
sudo apt-get install -y insomnia

# clean up
sudo apt autoremove -y
