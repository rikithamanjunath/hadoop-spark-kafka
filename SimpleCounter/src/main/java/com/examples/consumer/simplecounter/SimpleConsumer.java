package com.examples.consumer.simplecounter;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import kafka.consumer.Consumer;
import kafka.consumer.ConsumerConfig;
import kafka.consumer.ConsumerIterator;
import kafka.consumer.KafkaStream;
import kafka.javaapi.consumer.ConsumerConnector;

public class SimpleConsumer {

    public static void consume(String bootStrapServer, String topic, String groupId) {
        Properties props = new Properties();
        props.put("zookeeper.connect", "c7003:2181");
        props.put("bootstrap.servers", bootStrapServer);
        props.put("group.id", groupId);
        props.put("enable.auto.commit", "true");
        props.put("auto.commit.interval.ms", "1000");
        props.put("session.timeout.ms", "30000");
        props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        ConsumerConnector consumer =
                Consumer.createJavaConsumerConnector(new ConsumerConfig(props));
        Map<String, Integer> topicCountMap = new HashMap<String, Integer>();
        topicCountMap.put(topic, new Integer(1));
        KafkaStream<byte[], byte[]> stream =
                consumer.createMessageStreams(topicCountMap).get(topic).get(0);

        ConsumerIterator<byte[], byte[]> it = stream.iterator();

        // infinite loop
        while (it.hasNext()) {
            System.out.println(new String(it.next().message()));
        }

        // non-reachable code...
        consumer.shutdown();
    }

    public static void main(String[] args) {

        if (args.length < 3) {
            System.out.println(" BootStrapServer, topic, group.id");
        }
        consume(args[0], args[1], args[2]);

    }

}
