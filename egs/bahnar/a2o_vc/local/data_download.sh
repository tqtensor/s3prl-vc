#!/bin/bash

# Copyright 2022 Wen-Chin Huang (Nagoya University)
#  MIT License (https://opensource.org/licenses/MIT)

db=$1

# check arguments
if [ $# != 1 ]; then
    echo "Usage: $0 <db_root_dir>"
    exit 1
fi

# download dataset
cwd=$(pwd)
if [ ! -e ${db}/.done ]; then
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

    mkdir -p ${db}
    cd ${db}
    mc cp tqtensor-minio/bk-imp/tts-lab/vc/bahnar-parallel.zip .

    unzip '*.zip'
    rm bahnar-parallel.zip

    cd $cwd
    echo "Successfully finished download."
    touch ${db}/.done
else
    echo "Already exists. Skip download."
fi
