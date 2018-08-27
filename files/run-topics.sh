#!/bin/bash

# This script will parse comma-separated list of topics provided as an argument
# and run topics on Kafka Broker

if [ -z "$1" ]; then
    echo "Comma-separated list of topics wasn't provided"
    exit 1
fi

# Check if Kafka topic script is in place
if [ ! -e "/usr/local/kafka/bin/kafka-topics.sh" ]; then
    echo "kafka-topics.sh script wasn't found"
    exit 2
fi

IFS=',' read -ra TOPICS <<< "$1"
for i in "${TOPICS[@]}"; do
    if [[ $i =~ ^[a-zA-Z0-9]+$ ]]; then
        echo "Running topic: $i"
        /usr/local/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic $i
    else
        echo "Topic $i can't be used: Use only letters or numbers"
    fi
done