#
# Cookbook Name:: nginx-rbenv-passenger
# Recipe:: default
#
# Copyright 2015, newsdict
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'rbenv'
include_recipe 'rbenv-install-rubies'
include_recipe 'nginx-rbenv-passenger::commons_script'

passenger_version = node[:'nginx-rbenv-passenger'][:passenger][:version]

rbenv_gem :passenger do
  version passenger_version
end

execute "Compile the passenger" do
  not_if { File.exists?("#{node[:rbenv][:root_path]}/versions/2.2.0/lib/ruby/gems/2.2.0/gems/passenger-#{passenger_version}/buildout/") }
  command "#{node[:rbenv][:root_path]}/shims/passenger-install-nginx-module  --prefix=#{node[:'nginx-rbenv-passenger'][:nginx][:root_path]} --auto --auto-download && rm #{node[:'nginx-rbenv-passenger'][:nginx][:root_path]}/conf/nginx.conf"
  user 'root'
  group 'root'
  action :run
end

cookbook_file "nginx.init" do
  path "/etc/init.d/nginx"
  action :create
  mode '0755'
  user 'root'
  group 'root'
end

template "#{node[:'nginx-rbenv-passenger'][:nginx][:root_path]}/conf/nginx.conf" do
  source "nginx.conf.erb"
  mode '755'
  not_if { File.exists?("#{node[:'nginx-rbenv-passenger'][:nginx][:root_path]}/conf/nginx.conf") }
end

link "/usr/local/sbin/nginx" do
  to "#{node[:'nginx-rbenv-passenger'][:nginx][:root_path]}/sbin/nginx"
end

link "/etc/nginx" do
  to "#{node[:'nginx-rbenv-passenger'][:nginx][:root_path]}/conf"
end

link "/var/log/nginx" do
  to "#{node[:'nginx-rbenv-passenger'][:nginx][:root_path]}/logs"
end

directory "/var/cache/nginx" do
  action :create
  mode '0755'
  user 'root'
  group 'root'
end

directory "/etc/nginx/conf.d" do
  action :create
  mode '0755'
  user 'root'
  group 'root'
end

template "/etc/nginx/conf.d/passenger.conf" do
  source "passenger.conf.erb"
  mode '755'
end

directory "/etc/nginx/sites-available" do
  action :create
  mode '0755'
  user 'root'
  group 'root'
end

directory "/etc/nginx/sites-enabled" do
  action :create
  mode '0755'
  user 'root'
  group 'root' 
end