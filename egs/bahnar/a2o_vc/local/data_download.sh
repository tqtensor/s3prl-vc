#!/usr/bin/env bash
set -e

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
    # init MinIO
    export PATH=$PATH:$HOME/minio-binaries/

    mkdir -p ${db}
    cd ${db}
    mc cp tqtensor-minio/bk-imp/tts-lab/vc/bahnar-parallel.zip .

    unzip -q '*.zip' -d bahnar
    rm bahnar-parallel.zip

    cd $cwd
    echo "Successfully finished download."
    touch ${db}/.done
else
    echo "Already exists. Skip download."
fi
