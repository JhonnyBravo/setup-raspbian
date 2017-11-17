# 日本語入力関連パッケージ
%w(fonts-ipafont fonts-ipaexfont fonts-takao).each do |pkg|
  package pkg do
    action :install
  end
end
