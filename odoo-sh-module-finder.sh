#!/bin/bash
importstring=""
dirs=$(find "$1" -type f -name '.git' | sed -r 's|/[^/]+$||' |sort |uniq);
for n in $dirs
do
  importstring="$importstring , $n"
done
echo "${importstring:3}";
