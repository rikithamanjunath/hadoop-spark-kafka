package com.examples.consumer.simplecounter;

import org.I0Itec.zkclient.ZkClient;

public class ReadZoo {

    public static void main(String[] args) throws Exception {
//        ZooKeeper zk = new ZooKeeper("c7003:2181", 10000, null);
//        List<String> ids = zk.getChildren("/brokers/ids", false);
//        for (String id : ids) {
//            String brokerInfo = new String(zk.getData("/brokers/ids/" + id, false, null));
//            System.out.println(id + ": " + brokerInfo);
//        }
        
        ZkClient zkClient = new ZkClient("c7003:2181", 5000);
        zkClient.createEphemeral("/consumers/cpg/offsets/cpg/0", "0");

//    zkClient.writeData("/node2", "456", -1);
        Object node2 = zkClient.readData("/consumers/cpg/offsets/cpg/0");
        System.out.println(node2);

        zkClient.close();
    }
    
}
