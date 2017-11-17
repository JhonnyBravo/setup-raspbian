#!/bin/bash

script_name=$(basename "$0")

e_flag=0
j_flag=0

function usage(){
cat <<_EOT_
NAME
       ${script_name}

USAGE:
       ${script_name} [-e] [-j] [-h]


DESCRIPTION:
       ホームディレクトリ直下のディレクトリ名を英語化 / 日本語化します。 
       例) ~/ドキュメント -> ~/Documents

OPTIONS:
       -e     ディレクトリ名を英語化します。

       -j     ディレクトリ名を日本語化します。

       -h     ヘルプを表示します。
_EOT_
exit 1
}

while getopts "ejh" option
do
  case $option in
    e)
      e_flag=1
      ;;
    j)
      j_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ $e_flag -eq 1 ]; then
  LANG=C xdg-user-dirs-gtk-update
elif [ $j_flag -eq 1 ]; then
  xdg-user-dirs-gtk-update
fi
