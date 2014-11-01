#!/bin/sh

app=$1
path=${2:-$DEPLOYMENT_HELPER_TARGET}

link_name () { echo "$app-$1-$2"; }
link_path () { echo "$path/$(link_name $1 $2)"; }
