#
# Cookbook Name:: laravel
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'lamp'
include_recipe 'php::module_gd'
include_recipe 'cron'
include_recipe "composer"

%w{php5-json php5-curl}.each do |pkg|
  package pkg do
    action :install
  end
end
