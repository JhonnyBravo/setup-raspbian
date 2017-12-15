# set_smb_conf.rb
# ~/Templates/samba/smb.conf.erb -> /etc/samba/smb.conf

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/samba/"
DST="/etc/samba/"

template "#{DST}smb.conf" do
  action :create
  mode "644"
  source "#{SRC}smb.conf.erb"
end
