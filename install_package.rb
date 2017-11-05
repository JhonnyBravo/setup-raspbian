# 仮想マシン向けパッケージのインストール
%w(raspi-config build-essential module-assistant linux-headers-3.16.0-4-all).each do |pkg|
  package pkg do
    action :install
  end
end

# 日本語入力関連パッケージ
%w(fcitx-mozc fonts-ipafont fonts-ipaexfont fonts-takao).each do |pkg|
  package pkg do
    action :install
  end
end
