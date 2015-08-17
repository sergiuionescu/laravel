#
# Cookbook Name:: laravel
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'lamp'
include_recipe 'php::module_gd'
include_recipe 'cron'
include_recipe "composer"

git_client 'default' do
  action :install
end

%w{php5-json php5-curl}.each do |pkg|
  package pkg do
    action :install
  end
end

execute "laravel-installer" do
  command "composer global require 'laravel/installer'"
  not_if "composer show --installed|grep 'laravel/installer'"
end

project_root = "#{node['laravel']['project']['path']}/#{node['laravel']['project']['name']}"

execute "laravel-install-#{node['laravel']['project']['name']}" do
  cwd project_root
  command "laravel new #{node['laravel']['project']['name']}"
  not_if "ls #{project_root}"
end


web_app "laravel-#{node['laravel']['project']['name']}" do
  template "laravel.conf.erb"
  docroot "#{project_root}/web"
  server_name node['fqdn']
  server_aliases node['laravel']['project']['aliases']
end