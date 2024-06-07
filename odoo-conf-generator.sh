#!/bin/bash
if [ -f odoo.conf ]; then
  echo "odoo.conf file already exists. Please remove it first."
  exit 1
fi

if [ ! -d .git ]; then
  echo "This script should be run from the root of the repository."
  exit 1
fi

if [ $1 ]; then
  if [ $1 == "-h" ] || [ $1 == "--help" ]; then
    echo "This script generates an odoo.conf file with the addons_path set to the root of the repository and all its subdirectories."
    echo "Usage: ./odoo_conf_generator.sh [-h|--help] [version] [base-addons-path] [enterprise-path]"
    exit 0
  fi
fi

importstring=""
dirs=$(find $(pwd) -type f -name '.git' | sed -r 's|/[^/]+$||' |sort |uniq);
for n in $dirs
do
  importstring="$importstring , $n"
done
echo "${importstring:3}"; 

if [ $2 ]; then
  importstring="$importstring , $2"
fi

if [ $3 ]; then
  importstring="$importstring , $3"
fi

wget "https://github.com/odoo/odoo/blob/$1/debian/odoo.conf?raw=True" -O odoo.conf && grep -v "addons_path" odoo.conf > odoo.conf.tmp && echo "addons_path = ${importstring:3}" >> odoo.conf.tmp && mv odoo.conf.tmp odoo.conf




