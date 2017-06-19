
yum_package 'git'
yum_package 'wget'


service 'firewalld' do
  action :disable
end

service 'firewalld' do
  action :stop
end

user 'spark' do
  comment 'Spark user'
  home '/home/spark'
  shell '/bin/bash'
  username 'spark'
  manage_home true  
  action :create
end

directory '/home/spark' do
  owner 'spark'
  group 'spark'
  action :create
end


remote_file '/home/spark/spark-2.1.1-bin-hadoop2.7.tar.gz' do
  source 'https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz'
  owner 'spark'
  group 'spark'
  mode '0755'
  action :create
  not_if { ::File.exist?('/home/spark/spark-2.1.1-bin-hadoop2.7.tar.gz') }
end

execute 'extract spark' do
  cwd '/home/spark'
  user 'spark'
  command 'tar xzf ./spark-2.1.1-bin-hadoop2.7.tar.gz'
  not_if { ::File.directory?('/home/spark/spark') }
end



