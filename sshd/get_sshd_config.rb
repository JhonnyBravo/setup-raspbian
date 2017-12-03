# get_sshd_config.rb
# /etc/ssh/sshd_config -> ~/Templates/sshd/#{AUTH_TYPE}/sshd_config.erb

require 'dotenv'
Dotenv.load

AUTH_TYPE=ENV["AUTH_TYPE"] # password | public_key
USER_NAME=ENV["USER_NAME"]
SRC="/etc/ssh/"
DST="/home/#{USER_NAME}/Templates/sshd/#{AUTH_TYPE}/"

directory DST do
  action :create
  user USER_NAME
  owner USER_NAME
  group USER_NAME
end

template "#{DST}sshd_config.erb" do
  action :create
  mode "644"
  owner USER_NAME
  group USER_NAME
  source "#{SRC}sshd_config"
end
