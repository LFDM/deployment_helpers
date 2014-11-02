#!/bin/bash

app=$1
total_number=5

echo $app

link_name () { echo "$app-$1-$2"; }
link_path () { echo "$path/$(link_name $1 $2)"; }
