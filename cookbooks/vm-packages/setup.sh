#!/bin/bash

script_name=$(basename "$0")

function usage(){
cat <<_EOT_
NAME
       ${script_name}

USAGE:
       ${script_name} user_name [-h]


DESCRIPTION:
       Virtual Box のゲスト OS へ共有ディレクトリへのアクセス権を付与します。

ARGUMENTS:
       user_name
              共有ディレクトリへのアクセスを許可するユーザの名前。

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

user_name="$1"
gpasswd -a "$user_name" vboxsf
