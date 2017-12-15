# get_redmine_conf.rb
# /etc/apache2/sites-available/redmine.conf -> ~/Templates/redmine/redmine.conf.erb

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
DST="/home/#{USER_NAME}/Templates/redmine/"
SRC="/etc/apache2/sites-available/"

directory DST do
  action :create
  owner USER_NAME
  group USER_NAME
end

template "#{DST}redmine.conf.erb" do
  action :create
  mode "644"
  owner USER_NAME
  group USER_NAME
  source "#{SRC}redmine.conf"
end
