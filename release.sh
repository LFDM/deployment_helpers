#!/bin/sh

source ./common.sh

staging=$(link_path dev 1)
master=$(link_path prod 1)

staged_version=$(readlink -f staging)

rm $master
ln -s $staged_version $master
