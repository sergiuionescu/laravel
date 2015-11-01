#
# Cookbook Name:: laravel
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

actions :create, :delete
default_action :create

attribute :app_name, :kind_of => String,:name_attribute => true

attr_accessor :app_root
attr_accessor :exists