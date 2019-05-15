#! /bin/bash

authorized_keys=$HOME/.ssh/authorized_keys
ssh_dir=$(dirname $authorized_keys)

if [ -f $authorized_keys ]; then
  echo "$authorized_keys exists!"
  exit 1
fi

mkdir -p $ssh_dir
chmod 700 $ssh_dir
curl https://github.com/nonylene.keys > $authorized_keys
chmod 600 $authorized_keys
