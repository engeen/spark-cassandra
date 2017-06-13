service 'firewalld' do 
	action :stop
end


user 'deployer' do
  comment 'Deployer user'
  home '/home/deployer'
  shell '/bin/bash'
  username 'deployer'
  manage_home true  
  action :create
end

directory '/home/deployer' do
  owner 'deployer'
  group 'deployer'
  action :create
end


# execute 'create postgres role' do
#   user 'postgres'
#   command 'psql -c"CREATE ROLE pmon WITH CREATEDB LOGIN ENCRYPTED PASSWORD \'pmon\';"'
# end
