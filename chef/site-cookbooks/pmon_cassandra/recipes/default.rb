
service "firewalld" do 
  action :stop
end

service "firewalld" do 
  action :disable
end



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

# execute "firewall-cmd --permanent --add-port 7000/tcp --add-port 9042/tcp" do
#   user 'root'
# end

# execute "firewall-cmd --reload" do
#   user 'root'
# end

# execute 'systemctl daemon-reload' do
#   user 'root'
# end

service "cassandra" do
	action :enable
end

service "cassandra" do
	action :start
end
