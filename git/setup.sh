#!/bin/bash

script_name=$(basename "$0")

function usage(){
cat <<_EOT_
NAME
       ${script_name}

USAGE:
       ${script_name} [-h]


DESCRIPTION:
       git の初期設定を実行します。

OPTIONS:
       -h     ヘルプを表示します。
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

echo -n "ユーザ名を入力してください: "
read -r name

echo -n "E mail アドレスを入力してください: "
read -r email

git config --global color.ui auto
git config --global user.name "$name"
git config --global user.email "$email"
