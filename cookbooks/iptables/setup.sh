#!/bin/bash

#myhost=$(ifconfig eth0 \
myhost=$(ifconfig wlan0 \
  | awk 'NR==2 {print $2}' \
  | cut -d : -f 2)

if [ "${myhost:0:2}" -eq '10' ]; then
  trusthost="${myhost:0:7}0/24"
elif [ "${myhost:0:3}" -eq '192' ]; then
  trusthost="${myhost:0:10}0/24"
fi

# ssh_trusthost=''
# ssh_port=''

# if [ "${myhost:0:2}" -eq '10' ]; then
#   nmbd_trusthost="${myhost:0:7}255"
# elif [ "${myhost:0:3}" -eq '192' ]; then
#   nmbd_trusthost="${myhost:0:10}255"
# fi

# samba_trusthost=''

# apache2_trusthost=''

# vulsrepo_trusthost=''

any='0.0.0.0/0'

script_name=$(basename "$0")
i_flag=0
s_flag=0
r_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} [-i] [-s] [-r] [-h]

DESCRIPTION
  iptables のルール設定または設定済みルールの解除を実行します。

OPTIONS
  -i  iptables の設定を永続保存する為に必要なパッケージをインストールします。
  -s  iptables へルールを設定します。
  -r  iptables の設定済みルールを解除します。
  -h  ヘルプを表示します。
_EOT_
exit 1
}

function install(){
  apt-get update && apt-get install netfilter-persistent iptables-persistent
}

function remove_rules(){
  iptables -F
  iptables -Z
  iptables -X
  iptables -t nat -F
  iptables -t nat -Z
  iptables -t nat -X
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
  # SSH trusthost-> myhost
  iptables -A INPUT -p tcp --syn -m state --state NEW \
    -s $ssh_trusthost -d $myhost --dport $ssh_port -j ACCEPT
}

function set_rule_samba(){
  # Microsoft-DS SMB file sharing trusthost-> myhost
  iptables -A INPUT -p tcp --syn -m state --state NEW \
    -s $samba_trusthost -d $myhost --dport 445 -j ACCEPT

  # NetBIOS Session Service trusthost-> myhost
  iptables -A INPUT -p tcp --syn -m state --state NEW \
    -s $samba_trusthost -d $myhost --dport 139 -j ACCEPT

  # NetBIOS Name Service
  iptables -A INPUT -p udp \
    -d $nmbd_trusthost --sport 137 --dport 137 -j ACCEPT

  # NetBIOS Datagram Service
  iptables -A INPUT -p udp \
    -d $nmbd_trusthost --sport 138 --dport 138 -j ACCEPT
}

function set_rule_apache2(){
  iptables -A INPUT -p tcp --syn -m state --state NEW \
    -s $apache2_trusthost -d $myhost --dport 8000 -j ACCEPT
}

function set_rule_vulsrepo(){
  iptables -A INPUT -p tcp --syn -m state --state NEW \
    -s $vulsrepo_trusthost -d $myhost --dport 5111 -j ACCEPT
  iptables -A INPUT -p tcp --syn -m state --state NEW \
    -s $vulsrepo_trusthost -d $myhost --dport 80 -j ACCEPT
}

function set_rule_lxd(){
  # INPUT
  iptables -A INPUT -i lxdbr0 -p tcp -m tcp --dport 53 -j ACCEPT
  iptables -A INPUT -i lxdbr0 -p udp -m udp --dport 53 -j ACCEPT
  iptables -A INPUT -i lxdbr0 -p udp -m udp --dport 67 -j ACCEPT
  # OUTPUT
  iptables -A OUTPUT -o lxdbr0 -p tcp -m tcp --sport 53 -j ACCEPT
  iptables -A OUTPUT -o lxdbr0 -p udp -m udp --sport 53 -j ACCEPT
  iptables -A OUTPUT -o lxdbr0 -p udp -m udp --sport 67 -j ACCEPT
  # FORWARD
  iptables -A FORWARD -o lxdbr0 -j ACCEPT
  iptables -A FORWARD -i lxdbr0 -j ACCEPT
}

function set_rule_dns(){
  iptables -A INPUT -p udp \
    -s $any --sport 53 -d $myhost -j ACCEPT
}

function set_rule_ntp(){
  iptables -A INPUT -p udp \
    --sport 123 --dport 123 -d $myhost -j ACCEPT
  iptables -A INPUT -p udp \
    --sport 123 --dport 32768:60999 -d $myhost -j ACCEPT
}

function set_log(){
  iptables -N LOGGING
  iptables -A LOGGING -j LOG --log-level warning --log-prefix "DROP: " -m limit
  iptables -A LOGGING -j DROP
  iptables -A INPUT -j LOGGING
}

while getopts "isrh" option
do
  case $option in
    i)
      i_flag=1
      ;;
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
  set_rule_dns
  set_rule_ntp
  # set_rule_ssh
  # set_rule_samba
  # set_rule_apache2
  # set_rule_vulsrepo
  # set_rule_lxd
  set_log
elif [ $i_flag -eq 1 ]; then
  install
fi
