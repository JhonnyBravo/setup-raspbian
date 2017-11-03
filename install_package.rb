# package install
%w(raspi-config build-essential module-assistant linux-headers-3.16.0-4-all fcitx-mozc).each do |pkg|
  package pkg do
    action :install
  end
end
