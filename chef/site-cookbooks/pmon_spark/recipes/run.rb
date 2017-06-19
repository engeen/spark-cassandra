
# file '/home/spark/apps/spark/jars/spark-cassandra-connector.jar' do
#   content IO.binread('/home/spark/cassandra-connector/spark-cassandra-connector/target/full/scala-2.11/spark-cassandra-connector-assembly-2.0.2-26-g8ea8163.jar')
#   action  :create
#   not_if { ::File.exist?('/home/spark/apps/spark/jars/spark-cassandra-connector.jar') }
# end



execute "Start thrift server" do
	cwd '/home/spark'
    command "./thrift-cassandra-start.sh"
    user "spark"
end