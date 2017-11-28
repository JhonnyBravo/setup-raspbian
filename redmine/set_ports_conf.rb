# set_ports_conf.rb
# ~/Templates/redmine/ports.conf.erb -> /etc/apache2/ports.conf

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/redmine/"
DST="/etc/apache2/"

template "#{DST}ports.conf" do
  action :create
  mode "644"
  source "#{SRC}ports.conf.erb"
end
