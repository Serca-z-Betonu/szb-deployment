#!/bin/bash
sudo apt-get update
sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

mkdir testdir
touch testdir/somefile.xd

sudo groupadd docker
sudo usermod -aG docker $USER

sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

aws --profile default configure set aws_access_key_id "${access_key_id}"
aws --profile default configure set aws_secret_access_key "${secret_access_key}"

aws s3 cp s3://szb-deployment-bucket/docker-compose.yml .

sudo mv ./docker-compose.yml ~/docker-compose.yml

cd ~
sudo docker compose up
