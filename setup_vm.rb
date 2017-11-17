# 仮想マシン向けパッケージ
include_recipe "vm-packages/install_package.rb"

# 日本語入力関連パッケージ
include_recipe "japanese-packages/install_package.rb"

# その他ユーティリティ
include_recipe "xdg-user-dirs-gtk/install_package.rb"
include_recipe "vim/install_package.rb"
