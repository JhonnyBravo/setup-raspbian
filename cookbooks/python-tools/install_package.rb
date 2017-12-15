require 'itamae/plugin/resource/pip'

# python-pip, python-sphinx, python-tk のインストール
%w(python-pip python-sphinx python-tk).each do |pkg|
  package pkg do
    action :install
  end
end

# pip-init, autopep8, sphinx-intl のインストール
%w(pip-init autopep8 sphinx-intl).each do |pkg|
  pip pkg do
    action :install
  end
end
