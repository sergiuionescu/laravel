#
# Cookbook Name:: laravel
# Recipe:: test
#
# Copyright (c) 2014 The Authors, All Rights Reserved.


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