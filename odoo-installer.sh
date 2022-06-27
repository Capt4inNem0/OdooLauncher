#!/bin/bash

odoopath=~/.odoo;
if [ ! -d "$odoopath" ]; then mkdir $odoopath; fi

odoo15path=~/.odoo/15.0;
if [ ! -d "$odoo15path" ]; then mkdir $odoo15path; fi

odoo14path=~/.odoo/14.0;
if [ ! -d "$odoo14path" ]; then mkdir $odoo14path; fi

odoo13path=~/.odoo/13.0;
if [ ! -d "$odoo13path" ]; then mkdir $odoo13path; fi

function get_od15 () {
  if [ ! -d "$odoo15path/odoo" ]; then
    git clone --single-branch -b 15.0 https://github.com/odoo/odoo.git --depth=1 $odoo15path/odoo ;
  fi
  if [ ! -d "$odoo15path/pyvenv" ]; then
    python3 -m venv $odoo15path/pyvenv ;
    $odoo15path/pyvenv/bin/python3 -m pip install -r $odoo15path/odoo/requirements.txt
  fi
}
function get_od15e () {
  sudo git clone --single-branch -b 15.0 https://github.com/odoo/enterprise.git --depth=1 $odoo15path/enterprise ;
  sudo chown "$USER" $odoo15path/enterprise ;
}
function get_od14 () {
  if [ ! -d "$odoo14path/odoo" ]; then
    git clone --single-branch -b 14.0 https://github.com/odoo/odoo.git --depth=1 $odoo14path/odoo ;
  fi
  if [ ! -d "$odoo14path/pyvenv" ]; then
    python3 -m venv $odoo14path/pyvenv ;
    $odoo14path/pyvenv/bin/python3 -m pip install -r $odoo14path/odoo/requirements.txt
  fi
}

function get_od14e () {
  sudo git clone --single-branch -b 14.0 https://github.com/odoo/enterprise.git --depth=1 $odoo14path/enterprise ;
  sudo chown "$USER" $odoo14path/enterprise ;
}

function get_od13 () {
  if [ ! -d "$odoo13path/odoo" ]; then
    git clone --single-branch -b 13.0 https://github.com/odoo/odoo.git --depth=1 $odoo13path/odoo ;
  fi
  if [ ! -d "$odoo13path/pyvenv" ]; then
    python3 -m venv $odoo13path/pyvenv ;
    $odoo13path/pyvenv/bin/python3 -m pip install setuptools==57
    $odoo13path/pyvenv/bin/python3 -m pip install lxml greenlet pillow
    sed -i '22,23d' $odoo13path/odoo/requirements.txt
    sed -i '13,15d' $odoo13path/odoo/requirements.txt
    sed -i '9,10d' $odoo13path/odoo/requirements.txt
    $odoo13path/pyvenv/bin/python3 -m pip install -r $odoo13path/odoo/requirements.txt
  fi
}

function get_od13e () {
  sudo git clone --single-branch -b 13.0 https://github.com/odoo/enterprise.git --depth=1 $odoo13path/enterprise ;
  sudo chown "$USER" $odoo13path/enterprise ;
}

echo "Ingrese un numero:"
options=("Salir" "Instalar Odoo 15" "Instalar Odoo 15 Enterprise" "Instalar Odoo 14" "Instalar Odoo 14 Enterprise" "Instalar Odoo 13" "Instalar Odoo 13 Enterprise")
select i in "${options[@]}"; do
    case $i in
      "Instalar Odoo 15")
        get_od15
        break
        ;;
      "Instalar Odoo 15 Enterprise")
        get_od15e
        break
        ;;
      "Instalar Odoo 14")
        get_od14
        break
        ;;
      "Instalar Odoo 14 Enterprise")
        get_od14e
        break
        ;;
      "Instalar Odoo 13")
        get_od13
        break
        ;;
      "Instalar Odoo 13 Enterprise")
        get_od13e
        break
        ;;
      "Salir")
        break
        ;;
      *)
        echo "OPCION INVALIDA"
        ;;
    esac
done