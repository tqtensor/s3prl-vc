#!/bin/bash

# Copyright 2022 Wen-Chin Huang (Nagoya University)
#  MIT License (https://opensource.org/licenses/MIT)

# install MinIO
echo "Setup MinIO"

curl https://dl.min.io/client/mc/release/linux-amd64/mc \
    --create-dirs \
    -o $HOME/minio-binaries/mc

chmod +x $HOME/minio-binaries/mc
export PATH=$PATH:$HOME/minio-binaries/

read -p "Host: " host
read -p "User: " user
read -s -p "Password: " password

mc alias set tqtensor-minio $host $user $password
