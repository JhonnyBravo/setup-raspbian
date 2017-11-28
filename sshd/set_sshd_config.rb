# set_sshd_config.rb
# ~/Templates/sshd/#{AUTH_TYPE}/sshd_config.erb -> /etc/ssh/sshd_config

require 'dotenv'
Dotenv.load

AUTH_TYPE=ENV["AUTH_TYPE"] # password | public_key
USER_NAME=ENV["USER_NAME"]
DST="/etc/ssh/"
SRC="/home/#{USER_NAME}/Templates/sshd/#{AUTH_TYPE}/"

template "#{DST}sshd_config" do
  action :create
  mode "644"
  source "#{SRC}sshd_config.erb"
end
