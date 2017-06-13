template '/etc/yum.repos.d/datastax.repo' do
  source 'datastax.repo.erb'
  owner 'root'
  group 'root'
  mode '0755'
end


yum_package "dsc30"

template '/etc/cassandra/conf/cassandra.yaml' do
  source 'cassandra.yaml.erb'
  owner 'root'
  group 'root'
  mode '0755'
end


service "cassandra" do
	action :start
end

service "cassandra" do
	action :enable
end