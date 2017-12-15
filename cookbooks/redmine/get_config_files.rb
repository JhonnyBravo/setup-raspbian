# /etc/apache2/sites-available/redmine.conf
include_recipe "get_redmine_conf.rb"

# /etc/apache2/ports.conf
include_recipe "get_ports_conf.rb"

# /etc/apache2/mods-available/passenger.conf
include_recipe "get_passenger_conf.rb"
