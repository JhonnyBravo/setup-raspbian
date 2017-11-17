#!/bin/bash

script_name=$(basename "$0")

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} [-h]

DESCRIPTION
  Raspbian の初期設定を実行します。

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

# 一般ユーザの登録
echo "一般ユーザを登録します。"
echo -n "ユーザ名を入力してください: "
read -r user_name
pi_group=$(groups pi | tr " " "," | sed -e "s/pi,:,//")

adduser "$user_name"
usermod -G "$pi_group" "$user_name"

# root パスワード設定
echo "root のパスワードを変更します。"
passwd root
