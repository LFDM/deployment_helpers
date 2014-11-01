#!/bin/bash

source ./common.sh

build=$2
env=$3
path=${4:-$DEPLOYMENT_HELPER_TARGET}

cascade_links () {
  for i in $(seq $(($total_number - 1)) -1 1); do
    cascade_link $1 $i
  done
}

cascade_link () {
  old_link=$(link_path $1 $i)
  new_link=$(link_path $1 $(($i + 1)))
  old_target=$(readlink -f $old_link)
  rm $new_link
  ln -s $old_target $new_link
}

set_new_link () {
  link=$(link_path $1 1)
  rm $link
  ln -s $build $link
}

cascade_links $env
set_new_link $env $build
