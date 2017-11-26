require 'dotenv'
Dotenv.load

template "/etc/samba/smb.conf" do
  action :create
  mode "644"
  source "smb.conf.erb"
end
