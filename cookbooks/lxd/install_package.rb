# snapd, btrfs-progs のインストール
%w(snapd btrfs-progs).each do |pkg|
  package pkg do
    action :install
  end
end
