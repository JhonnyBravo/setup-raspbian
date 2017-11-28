# get_smb_conf.rb
# /etc/samba/smb.conf -> ~/Templates/samba/smb.conf.erb

require 'dotenv'
Dotenv.load

USER_NAME=ENV["USER_NAME"]
DST="/home/#{USER_NAME}/Templates/samba/"
SRC="/etc/samba/"

directory DST do
  action :create
  owner USER_NAME
  group USER_NAME
end

template "#{DST}smb.conf.erb" do
  action :create
  mode "644"
  owner USER_NAME
  group USER_NAME
  source "#{SRC}smb.conf"
end
