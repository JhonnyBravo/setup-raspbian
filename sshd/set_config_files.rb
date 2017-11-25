require 'dotenv'
Dotenv.load

if ENV["AUTH_TYPE"] == "password"
  PATH="password_auth"
elsif ENV["AUTH_TYPE"] == "public_key"
  PATH="public_key_auth"

  # ~/.ssh/authorized_keys
  USER_NAME=ENV["USER_NAME"]

  directory "/home/#{USER_NAME}/.ssh" do
    action :create
    mode "700"
    owner USER_NAME
    group USER_NAME
  end

  template "/home/#{USER_NAME}/.ssh/authorized_keys" do
    action :create
    mode "600"
    owner USER_NAME
    group USER_NAME
    source "#{PATH}/authorized_keys.erb"
  end
end

# sshd_config
template "/etc/ssh/sshd_config" do
  action :create
  mode "644"
  source "#{PATH}/sshd_config.erb"
end
