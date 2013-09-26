#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright (C) 2013 Sous
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'

directory "/opt"
directory "/opt/debs"

git '/opt/debs/mediaproxy-ng-precise' do
  repository "https://github.com/sous/mediaproxy-ng-precise.git"
  reference 'master'
  action :sync
end

execute 'apt-key add /opt/debs/mediaproxy-ng-precise/apt-key.gpg' do
  command 'cat /opt/debs/mediaproxy-ng-precise/apt-key.gpg | apt-key add -'
end

include_recipe 'apt'

apt_repository 'mediaproxy-ng-precise' do
  uri 'file:///opt/debs/mediaproxy-ng-precise'
  distribution node['lsb']['codename']
  components ["main"]
  action :add
end

package 'ngcp-mediaproxy-ng'

