#
# Cookbook Name:: laravel
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'lamp'
include_recipe 'php::module_gd'
include_recipe 'cron'
include_recipe "composer"


# Start laravel install
laravel_app "laravel" do
  action :create
end
web_app "laravel-test" do
  template "laravel.conf.erb"
  docroot "/var/www/laravel/public"
  server_name 'laravel.local'
  server_aliases []
end
#End laravel install