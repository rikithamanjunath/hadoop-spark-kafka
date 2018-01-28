whoami
sleep 2

export JAVA_VERSION=1.8.0
export KAFKA_PRE=kafka_2.11-
export KAFKA_VERSION=0.10.1.1
export ZOO_VERSION=3.4.8

yum install wget -y
yum install java -y
yum install java-$JAVA_VERSION-openjdk-headless -y
#yum update -y
yum install telnet -y

sudo su

wget https://archive.apache.org/dist/kafka/$KAFKA_VERSION/$KAFKA_PRE$KAFKA_VERSION.tgz
tar -xvf $KAFKA_PRE$KAFKA_VERSION.tgz
cd $KAFKA_PRE$KAFKA_VERSION/config/

sed -i '34s/#//' server.properties 

cd ../../

wget https://archive.apache.org/dist/zookeeper/zookeeper-$ZOO_VERSION/zookeeper-$ZOO_VERSION.tar.gz
tar -xvf zookeeper-$ZOO_VERSION.tar.gz
cp zookeeper-$ZOO_VERSION/conf/zoo_sample.cfg zookeeper-$ZOO_VERSION/conf/zoo.cfg


export JAVA_VERSION=1.8.0
export KAFKA_PRE=kafka_2.11-
export KAFKA_VERSION=0.10.1.1
export ZOO_VERSION=3.4.8

#sh zookeeper-$ZOO_VERSION/bin/zkServer.sh start
#nohup sh $KAFKA_PRE$KAFKA_VERSION/bin/kafka-server-start.sh $KAFKA_PRE$KAFKA_VERSION/config/server.properties &
#sleep 5
#sh $KAFKA_PRE$KAFKA_VERSION/bin/kafka-topics.sh --create --zookeeper 192.168.70.102:2181 --replication-factor 1 --partitions 1 --topic test

echo " Java version" >> /vagrant/data/output/kafka-output.txt
echo "$JAVA_VERSION" >> /vagrant/data/output/kafka-output.txt
echo "Kafka Version" >> /vagrant/data/output/kafka-output.txt
echo $KAFKA_VERSION  >> /vagrant/data/output/kafka-output.txt
echo "Zookeeper version" >> /vagrant/data/output/kafka-output.txt
echo $ZOO_VERSION >> /vagrant/data/output/kafka-output.txt

sed '/127.0.0.1*/d' -i /etc/hosts
echo "127.0.0.1  localhost localhost.localdomain localhost4 localhost4.localdomain4" >> /etc/hosts
echo "192.168.70.102 c7002.dev.com c7002"  >> /etc/hosts
