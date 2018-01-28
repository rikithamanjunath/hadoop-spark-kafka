## Testing Setup

- Comes with setup of Kafka, Zookeeper, Redis and Mysql on Centos 6.0 
- Kafka port 9092, Zookeeper 2181 
- Run command  'sudo echo "192.168.70.102 c7002.dev.com c7002" >> /etc/hosts' on your local Machine
- Run start.sh to begin and go for coffee - will take 10 min first time
- to suspend 'Vagrant suspend'
- to resume  'Vagrant resume --no-provision'
- to destory 'Vagrant destroy'

```
sudo su
/usr/local/hadoop-2.7.2/sbin/hadoop-daemon.sh start datanode
/usr/local/hadoop/bin/hadoop dfs -put /vagrant/data/../SimpleCounter/README.md /
/usr/local/spark/bin/spark-shell
```


```
val textFile = sc.textFile("hdfs://c7002.dev.com:8020/README.md")
val counts = textFile.flatMap(line => line.split(" ")) .map(word => (word, 1)).reduceByKey(_ + _)
counts.saveAsTextFile("hdfs://c7002.dev.com:8020/out.txt")
hdfs dfs -cat /out.txt/part-00000
```
