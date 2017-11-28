# set_passenger_conf.rb
# ~/Templates/redmine/passenger.conf.erb -> /etc/apache2/mods-available/passenger.conf

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/redmine/"
DST="/etc/apache2/mods-available/"

template "#{DST}passenger.conf" do
  action :create
  mode "644"
  source "#{SRC}passenger.conf.erb"
end
