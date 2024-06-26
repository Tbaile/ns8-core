#!/bin/sh 

# this script is made to install dependencies for cross compiling in golang

set -e

if [ "$GOOS" != "linux" ]; then
    echo "GOOS must be linux"
    exit 1
fi

if [ "$GOARCH" = "arm64" ]; then
    apt-get update
    apt-get install -y gcc-aarch64-linux-gnu
    export CC=aarch64-linux-gnu-gcc
elif [ "$GOARCH" = "arm" ] && [ "$TARGETVARIANT" = "v7" ]; then
    export GOARM=7
    apt-get update
    apt-get install -y gcc-arm-linux-gnueabihf
    export CC=arm-linux-gnueabihf-gcc
fi

CGO_ENABLED=1 go build -v -ldflags='-extldflags=-static' -tags sqlite_omit_load_extension api-server.go