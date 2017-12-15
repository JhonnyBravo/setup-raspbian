# /etc/ssh/sshd_config
include_recipe "set_sshd_config.rb"

# ~/.ssh/authorized_keys
include_recipe "set_authorized_keys.rb"
