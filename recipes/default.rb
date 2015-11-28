#
# Cookbook Name:: laravel
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'lamp'

execute "laravel-installer" do
  command "composer global require 'laravel/installer'"
  not_if "ls ~/.composer/vendor/bin/laravel"
end

