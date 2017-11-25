#!/bin/bash

myhost=$(ifconfig eth0 \
  | awk 'NR==2 {print $1}' \
  | cut -d : -f 2)

if [ "${myhost:0:2}" -eq '10' ]; then
  trusthost="${myhost:0:7}0/24"
elif [ "${myhost:0:3}" -eq '192' ]; then
  trusthost="${myhost:0:10}0/24"
fi

any='0.0.0.0/0'

script_name=$(basename "$0")
s_flag=0
r_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} [-s] [-r] [-h]

DESCRIPTION
  iptables のルール設定または設定済みルールの解除を実行します。

OPTIONS
  -s  iptables へルールを設定します。
  -r  iptables の設定済みルールを解除します。
  -h  ヘルプを表示します。
_EOT_
exit 1
}

function remove_rules(){
  iptables -F
  iptables -Z
  iptables -X
  iptables -P INPUT ACCEPT
  iptables -P OUTPUT ACCEPT
  iptables -P FORWARD ACCEPT
}

function set_policy(){
  iptables -P INPUT DROP
  iptables -P OUTPUT ACCEPT
  iptables -P FORWARD DROP
}

function set_rule_lo(){
  iptables -A INPUT -i lo -j ACCEPT
}

function set_rule_icmp(){
  # ICMP trusthost->myhost
  iptables -A INPUT -p icmp --icmp-type echo-request \
    -s $trusthost -d $myhost -j ACCEPT

  # ICMP myhost->trusthost
  iptables -A INPUT -p icmp --icmp-type echo-reply \
    -s $trusthost -d $myhost -j ACCEPT
}

function set_rule_tcp(){
  iptables -A INPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
}

function set_rule_ssh(){
  # ssh trusthost-> myhost
  iptables -A INPUT -p tcp --syn -m state --state NEW \
    -s $trusthost -d $myhost --dport 22 -j ACCEPT
}

function set_rule_http(){
  iptables -A INPUT -p tcp --syn -m state --state NEW \
    -s $any -d $myhost --dport 80 -j ACCEPT
}

function set_rule_dns(){
  iptables -A INPUT -p udp \
    -s $any --sport 53 -d $myhost -j ACCEPT
}

function set_log(){
  iptables -N LOGGING
  iptables -A LOGGING -j LOG --log-level warning --log-prefix "DROP: " -m limit
  iptables -A LOGGING -j DROP
  iptables -A INPUT -j LOGGING
}

while getopts "srh" option
do
  case $option in
    s)
      s_flag=1
      ;;
    r)
      r_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ $r_flag -eq 1 ]; then
  remove_rules
elif [ $s_flag -eq 1 ]; then
  remove_rules
  set_policy
  set_rule_lo
  set_rule_icmp
  set_rule_tcp
  # set_rule_ssh
  # set_rule_http
  set_rule_dns
  set_log
fi