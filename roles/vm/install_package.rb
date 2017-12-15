# 仮想マシン向けパッケージ
include_recipe "../../cookbooks/vm-packages/install_package.rb"

# 日本語入力関連パッケージ
include_recipe "../../cookbooks/japanese-packages/install_package.rb"

# その他ユーティリティ
include_recipe "../../cookbooks/xdg-user-dirs-gtk/install_package.rb"
include_recipe "../../cookbooks/vim/install_package.rb"
