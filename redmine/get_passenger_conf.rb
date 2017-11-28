# get_passenger_conf.rb
# /etc/apache2/mods-available/passenger.conf -> ~/Templates/redmine/passenger.conf.erb

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
DST="/home/#{USER_NAME}/Templates/redmine/"
SRC="/etc/apache2/mods-available/"

directory DST do
  action :create
  owner USER_NAME
  group USER_NAME
end

template "#{DST}passenger.conf.erb" do
  action :create
  mode "644"
  owner USER_NAME
  group USER_NAME
  source "#{SRC}passenger.conf"
end
