#!/bin/bash
FILE='/configured.txt'

# ENV Variables with defaults
SEEDS=${CASSANDRA_SEEDS:-scylla-0.scylla.default.svc.cluster.local}
DC=${CASSANDRA_DC:-DC1}
RACK=${CASSANDRA_RACK}
ENDPOINT_SNITCH=${CASSANDRA_ENDPOINT_SNITCH:-GossipingPropertyFileSnitch}

# get IP from docker hostname
IP=`cat /etc/hosts | grep $(hostname) |  awk '{ print $1 }'`
# fallback to first interface
if [ -z "$IP" ]; then
  IP=`ip addr | grep eth0  | tail -n1 | cut -d ' ' -f 6 | cut -d '/' -f 1`
fi

if [ ! -f "$FILE" ]
then
  sed -i "s/seeds: \"127.0.0.1\"/seeds: \"$CASSANDRA_SEEDS\"/g" /etc/scylla/scylla.yaml

  if [ -n "${DC1}" ]; then
  echo 'dc='$DC > /etc/scylla/cassandra-rackdc.properties
  fi

 echo 'prefer_local=true' >> /etc/scylla/cassandra-rackdc.properties
 echo 'rack=' $RACK >> /etc/scylla/cassandra-rackdc.properties
 echo 'endpoint_snitch: ' $ENDPOINT_SNITCH >> /etc/scylla/scylla.yaml
 echo 'listen_address: ' $IP >> /etc/scylla/scylla.yaml
 echo 'rpc_address: ' $IP >> /etc/scylla/scylla.yaml
 echo 'start_native_transport: true' >> /etc/scylla/scylla.yaml
touch /configured.txt

fi

export SCYLLA_CONF='/etc/scylla'
/usr/bin/scylla --developer-mode 1 --options-file /etc/scylla/scylla.yaml&
/usr/lib/scylla/jmx/scylla-jmx -l /usr/lib/scylla/jmx&
sleep infinity
