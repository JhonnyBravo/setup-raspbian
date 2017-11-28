# /etc/apache2/sites-available/redmine.conf
include_recipe "set_redmine_conf.rb"

# /etc/apache2/ports.conf
include_recipe "set_ports_conf.rb"

# /etc/apache2/mods-available/passenger.conf
include_recipe "set_passenger_conf.rb"

# 設定ファイル有効化
execute "a2ensite redmine" do
  action :run
end

service "apache2" do
  action :restart
end
