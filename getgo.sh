#!/bin/bash

goversion=$1

profilefile=".bashrc"

goinstallarch="linux-amd64"

filename="go$goversion.$goinstallarch.tar.gz"

url="https://golang.org/dl/$filename"

downloadpath="/tmp/go"

installpath="/usr/local"

currentpath="$installpath/go"

binpath="$currentpath/bin"

echo "checking for $downloadpath/$filename"
if [ -f "$downloadpath/$filename" ]; then
    echo "$downloadpath/$filename already exists... skipping download"
else
    echo "downloading $url to $downloadpath"
    wget -P $downloadpath $url
fi

if [ $? -ne 0 ]; then
    echo "download of $url failed, halting install"
else
    echo "removing existing go version from $currentpath"
    sleep 1m
    rm -rf $currentpath
    mkdir $currentpath

    echo "unzipping $filename archive to $installpath"
    tar -C $installpath -xzf $downloadpath/$filename

    echo "checking for existing .bashrc env var setup and path modifications"
fi
