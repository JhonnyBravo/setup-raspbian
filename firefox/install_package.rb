# firefox のインストール
%w(firefox-esr firefox-esr-l10n-ja).each do |pkg|
  package pkg do
    action :install
  end
end
