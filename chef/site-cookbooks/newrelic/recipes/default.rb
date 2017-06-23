
execute 'get newrelic rpm' do
  user 'root'
  command 'rpm -Uvh https://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm'
end

yum_package 'newrelic-sysmond'


execute 'register license' do
  user 'root'
  command 'nrsysmond-config --set license_key=69ce0ffeb1ab7e55ec8a988c8d050f513a3d0ffb'
end

service 'newrelic-sysmond' do
  action :enable
end

service 'newrelic-sysmond' do
  action :start
end