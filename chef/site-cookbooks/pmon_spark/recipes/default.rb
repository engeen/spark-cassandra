
yum_package 'git'
yum_package 'wget'

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
end

execute 'extract spark' do
  cwd '/home/spark'
  user 'spark'
  command 'tar xzf ./spark-2.1.1-bin-hadoop2.7.tar.gz'
  not_if { ::File.directory?('/home/spark/spark') }
end



execute 'get connector' do
  cwd '/home/spark'
  user 'spark'
  command 'git clone https://github.com/datastax/spark-cassandra-connector.git ./cassandra-connector'
  not_if { ::File.directory?('/home/spark/cassandra-connector') }
end


bash 'install scala' do
  	code <<-EOH
    wget http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.rpm
    sudo yum -y install scala-2.11.8.rpm
    EOH
end



execute 'build connector' do
  cwd '/home/spark/cassandra-connector'
  user 'spark'
  command './sbt/sbt -Dscala-2.11=true assembly'
  not_if { ::File.exist?('/home/spark/cassandra-connector/spark-cassandra-connector/target/full/scala-2.11/spark-cassandra-connector-assembly-*.jar') }
end

%w[ /home/spark/apps /home/spark/apps/spark /home/spark/apps/spark/jars ].each do |path|
	directory path do
	  owner 'spark'
	  group 'spark'
	  action :create
	  not_if { ::File.directory?(path) }
	end
end


template '/home/spark/spark-2.1.1-bin-hadoop2.7/conf/spark-defaults.conf' do
  source 'spark-defaults.conf.erb'
  owner 'spark'
  group 'spark'
  mode '0700'
end

execute "copy connector jar" do
    command "mv /home/spark/cassandra-connector/spark-cassandra-connector/target/full/scala-2.11/spark-cassandra-connector-assembly-*.jar /home/spark/apps/spark/jars/spark-cassandra-connector.jar"
    user "spark"
    not_if { ::File.exist?('/home/spark/apps/spark/jars/spark-cassandra-connector.jar') }
end

template '/home/spark/thrift-cassandra-start.sh' do
  source 'thrift-cassandra-start.sh.erb'
  owner 'spark'
  group 'spark'
  mode '0755'
end
