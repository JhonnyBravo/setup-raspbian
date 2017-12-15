require 'dotenv'
Dotenv.load

USER_NAME=ENV['USER_NAME']
GIT_USER_NAME=ENV['GIT_USER_NAME']
EMAIL_ADDRESS=ENV['EMAIL_ADDRESS']

# git のインストール
package "git" do
  action :install
end

# 初期設定
[
  "git config --global color.ui auto",
  "git config --global user.name '#{GIT_USER_NAME}'",
  "git config --global user.email #{EMAIL_ADDRESS}"
].each do |command|
  execute command do
    user USER_NAME
  end
end
