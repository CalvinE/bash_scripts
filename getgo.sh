#!/bin/bash

goversion=$1

profilefile="/home/$SUDO_USER/.bashrc"

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

fi

echo "checking for existing $profilefile env var setup and path modifications"

grep -Fxq "export GOROOT=/usr/local/go" $profilefile
if [ $? -ne 0 ]; then
    echo "adding GOROOT"
    echo "export GOROOT=$currentpath" >> $profilefile
fi

grep -Fxq "export GOPATH=\$HOME/go" $profilefile
if [ $? -ne 0 ]; then
    echo "adding GOPATH"
    echo "export GOPATH=\$HOME/go" >> $profilefile
fi

grep -Fxq "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" $profilefile
if [ $? -ne 0 ]; then
    echo "adding go to PATH"
    echo "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> $profilefile
fi

echo "done"

