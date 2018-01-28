
INFRA_HOME=/usr/local/

##SCALA
SCALA_HOME=$INFRA_HOME/scala
mkdir -p $SCALA_HOME
wget http://downloads.typesafe.com/scala/2.11.7/scala-2.11.7.tgz
tar -xf scala-2.11.7.tgz -C $SCALA_HOME --strip-components=1
export PATH=$PATH:$SCALA_HOME/bin/

SPARK_HOME=$INFRA_HOME/spark
mkdir -p $SPARK_HOME
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
tar -xf spark-2.1.0-bin-hadoop2.7.tgz -C $SPARK_HOME --strip-components=1
export PATH=$PATH:$SPARK_HOME/bin/
