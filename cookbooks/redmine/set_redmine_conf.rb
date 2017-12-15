# set_redmine_conf.rb
# ~/Templates/redmine/redmine.conf.erb -> /etc/apache2/sites-available/redmine.conf

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/redmine/"
DST="/etc/apache2/sites-available/"

template "#{DST}redmine.conf" do
  action :create
  mode "644"
  source "#{SRC}redmine.conf.erb"
end
