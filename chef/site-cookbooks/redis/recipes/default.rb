yum_package 'redis'

service 'redis' do 
  action :start
end

service 'redis' do 
  action :enable
end