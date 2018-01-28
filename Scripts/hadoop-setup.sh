source "/vagrant/data/common.sh"

function installLocalHadoop {
	echo "install hadoop from local file"
	FILE=/vagrant/data/hadoop-resources/$HADOOP_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteHadoop {
	echo "install hadoop from remote file"
	wget $HADOOP_MIRROR_DOWNLOAD -P  /vagrant/data/hadoop-resources/
	tar -xzf /vagrant/data/hadoop-resources/$HADOOP_ARCHIVE -C /usr/local
}

function setupHadoop {
	echo "creating hadoop directories"
	mkdir /var/hadoop
	mkdir /var/hadoop/hadoop-datanode
	mkdir /var/hadoop/hadoop-namenode
	mkdir /var/hadoop/mr-history
	mkdir /var/hadoop/mr-history/done
	mkdir /var/hadoop/mr-history/tmp
	
	echo "copying over hadoop configuration files"
	cp -f $HADOOP_RES_DIR/* $HADOOP_CONF
}

function setupEnvVars {
	echo "creating hadoop environment variables"
	cp -f $HADOOP_RES_DIR/hadoop.sh /etc/profile.d/hadoop.sh
	. /etc/profile.d/hadoop.sh
}

function installHadoop {
	if resourceExists $HADOOP_ARCHIVE; then
		installLocalHadoop
	else
		installRemoteHadoop
	fi
	ln -s /usr/local/$HADOOP_VERSION /usr/local/hadoop
}

function formatHdfs {
    echo "formatting HDFS"
    hdfs namenode -format
}

function startDaemons {
    /vagrant/data/start-hadoop.sh
}


function setupHdfs {
    echo "creating user home directory in hdfs"
    hdfs dfs -mkdir -p /user/root
    hdfs dfs -mkdir -p /user/vagrant
    hdfs dfs -chown vagrant /user/vagrant

    echo "creating temp directories in hdfs"
    hdfs dfs -mkdir -p /tmp
    hdfs dfs -chmod -R 777 /tmp

    hdfs dfs -mkdir -p /var
    hdfs dfs -chmod -R 777 /var
}

echo "setup hadoop"
installHadoop
setupHadoop
setupEnvVars
formatHdfs
sudo su
mkdir -p /usr/local/hadoop/logs/
chmod 777 /usr/local/hadoop/logs/
startDaemons
setupHdfs
echo "hadoop setup complete"
