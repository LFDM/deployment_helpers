#!/bin/bash

source ./common.sh

env=$2
path=${3:-$DEPLOYMENT_HELPER_TARGET}

propagate_links () {
  for i in $(seq 1 $(($total_number - 1))); do
    propagate_link $1 $i
  done
}

propagate_link () {
  old_link=$(link_path $1 $i)
  new_link=$(link_path $1 $(($i + 1)))
  new_target=$(readlink -f $new_link)

  rm $old_link
  ln -s $new_target $old_link
}

propagate_links $env
