use_inline_resources

action :create do
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
    not_if "ls ~/.composer/vendor/bin/laravel"
  end

  project_root = "/var/www/#{new_resource.name}"

  execute "laravel-install-#{new_resource.name}" do
    cwd "/var/www"
    command "composer create-project laravel/laravel #{new_resource.name}"
    not_if "ls #{project_root}"
  end

  execute "laravel-#{new_resource.name}-permissions" do
    command "chown #{node['apache']['user']}:#{node['apache']['group']} -R #{project_root}"
  end
end