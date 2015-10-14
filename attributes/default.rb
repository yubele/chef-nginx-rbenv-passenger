node.default[:'nginx-rbenv-passenger'][:passenger][:version] = '5.0.13'
node.default[:'nginx-rbenv-passenger'][:nginx][:root_path] = '/usr/local/nginx'
node.default['nginx']['script_dir'] = '/usr/sbin'
case node['platform_family']
when 'debian'
  node.default[:'nginx-rbenv-passenger'][:packages] = []
  node.default[:'nginx-rbenv-passenger'][:user] = 'www-data'
when 'rhel'
  node.default[:'nginx-rbenv-passenger'][:packages] = ['libcurl-devel']
  node.default[:'nginx-rbenv-passenger'][:user] = 'root'
end