# /etc/apache2/sites-available/redmine.conf
template "/etc/apache2/sites-available/redmine.conf" do
  action :create
  mode "644"
  source "redmine.conf.erb"
end

# /etc/apache2/ports.conf
template "/etc/apache2/ports.conf" do
  action :create
  mode "644"
  source "ports.conf.erb"
end

# /etc/apache2/mods-available/passenger.conf
template "/etc/apache2/mods-available/passenger.conf" do
  action :create
  mode "644"
  source "passenger.conf.erb"
end

# 設定ファイル有効化
execute "a2ensite redmine" do
  action :run
end

service "apache2" do
  action :restart
end
