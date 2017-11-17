# 仮想マシン向けパッケージのインストール
%w(build-essential module-assistant linux-headers-3.16.0-4-all).each do |pkg|
  package pkg do
    action :install
  end
end
