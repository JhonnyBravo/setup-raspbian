# set_nftables_conf.rb
# ~/Templates/nftables/nftables.conf.erb -> /etc/nftables.conf

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/nftables/"
DST="/etc/"

template "#{DST}nftables.conf" do
  action :create
  mode "755"
  source "#{SRC}nftables.conf.erb"
end
