#!/bin/bash

set -e

app=$1
total_number=5

if [ -z $app ]; then
  echo "Need an app name to run!"
  exit 1
fi

link_name () { echo "$app-$1-$2"; }
link_path () { echo "$path/$(link_name $1 $2)"; }

create_link () {
  ln -s $1 $2
  echo "Linking $2 to $1"
}
