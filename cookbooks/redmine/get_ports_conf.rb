# get_ports_conf.rb
# /etc/apache2/ports.conf -> ~/Templates/redmine/ports.conf.erb

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
DST="/home/#{USER_NAME}/Templates/redmine/"
SRC="/etc/apache2/"

directory DST do
  action :create
  owner USER_NAME
  group USER_NAME
end

template "#{DST}ports.conf.erb" do
  action :create
  mode "644"
  owner USER_NAME
  group USER_NAME
  source "#{SRC}ports.conf"
end
