#!/bin/bash

script_name=$(basename "$0")

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} user_name [-h]

DESCRIPTION
  snapd 版 lxd をインストールします。

ARGUMENTS
  user_name  lxd グループへ登録したいユーザの名前。

OPTIONS
  -h  ヘルプを表示します。
_EOT_
exit 1
}

while getopts "h" option
do
  case $option in
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

snap install lxd --channel=3.0
user_name="$1"
gpasswd -a "$1" lxd
