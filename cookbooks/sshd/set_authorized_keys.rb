# set_authorized_keys.rb
# ~/Templates/sshd/public_key/authorized_keys.erb -> ~/.ssh/authorized_keys

require 'dotenv'
Dotenv.load

AUTH_TYPE=ENV["AUTH_TYPE"] # password | public_key
USER_NAME=ENV["USER_NAME"]
SRC="/home/#{USER_NAME}/Templates/sshd/#{AUTH_TYPE}/"
DST="/home/#{USER_NAME}/.ssh/"

if AUTH_TYPE == "public_key"
  directory DST do
    action :create
    mode "700"
    owner USER_NAME
    group USER_NAME
  end

  template "#{DST}authorized_keys" do
    action :create
    mode "600"
    owner USER_NAME
    group USER_NAME
    source "#{SRC}authorized_keys.erb"
  end
end
