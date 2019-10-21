#! /bin/bash

set -ex

mkdir $HOME/local/bin -p

TEMP=`mktemp -d`
pushd $TEMP

filename="yaml2json-`uname -o`-`uname -m`"

wget https://github.com/nonylene/yaml2json/releases/latest/download/$filename.zip
unzip $filename.zip
chmod +x $filename/yaml2json
cp $filename/yaml2json $HOME/local/bin/

popd
rm -rf $TEMP
