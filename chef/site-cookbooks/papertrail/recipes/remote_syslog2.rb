remote_file 'remote_syslog2-0.19-1.x86_64.rpm' do
  user 'root'
  source 'https://github.com/papertrail/remote_syslog2/releases/download/v0.19/remote_syslog2-0.19-1.x86_64.rpm'
  action :create_if_missing
end

yum_package 'remote_syslog' do
  source 'remote_syslog2-0.19-1.x86_64.rpm'
end

template '/etc/log_files.yml' do
  source 'log_files.yml.erb'
  owner 'root'
  group 'root'
end

template '/etc/init.d/remote_syslog' do
  source 'init.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'remote_syslog' do
  action :enable
end

service 'remote_syslog' do
  action :restart
end
