* CassandraNode 192.168.2.3
* vagrant ssh cassandra
* cqlsh 192.168.2.3
* cqlsh> DESCRIBE SCHEMA;


* Spark Node 192.168.2.4
* http://192.168.2.4:4040/jobs/
* vagrant ssh spark
* sudo su spark && cd ~/
* spark*/bin/beeline -u jdbc:hive2://192.168.2.4:10000
* >  create table schedule_nodes using org.apache.spark.sql.cassandra options (cluster 'Test Cluster', keyspace 'app_development', table 'schedule_nodes');
* > select * from schedule_nodes

*
* Start/stop thrift:
* bash> ./spark/sbin/start-thriftserver.sh –hiveconf hive.server2.thrift.port 10000 –jars ~/connector.jar –driver-class-path ~/connector.jar



* spark-default.conf

* spark.driver.extraClassPath /home/spark/connector.jar
* spark.executor.extraClassPath /home/spark/connector.jar
* spark.cassandra.connection.host 192.168.2.3