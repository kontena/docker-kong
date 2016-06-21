#!/bin/sh
erb /etc/kong/kong.yml.erb > /etc/kong/kong.yml

echo "Waiting for cassandra on $CASSANDRA_URL:9042..." \
  && while ! nc $CASSANDRA_URL 9042; do sleep 0.3; done \
  && echo "Cassandra is ready! Launching Kong..." \
  && kong start
