#!/bin/bash

# Sets up the basic file structure for our linking system

source ./common.sh

path=${2:-$DEPLOYMENT_HELPER_TARGET}

generate_empty_links () {
  for i in $(seq 1 $total_number); do
    touch "$(link_path $1 $i)"
  done
}

link_to_link () {
  ln -s "$(link_path $1 1)" "$path/$2" 
}

generate_empty_links prod
generate_empty_links dev

link_to_link prod $app prod
link_to_link dev "$app-staging"
