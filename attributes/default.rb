node.default[:'nginx-rbenv-passenger'][:passenger][:version] = '5.0.13'
node.default[:'nginx-rbenv-passenger'][:nginx][:root_path] = '/usr/local/nginx'
node.default['nginx']['script_dir'] = '/usr/sbin'