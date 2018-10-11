#!/bin/bash
nodes=$(yarn node -list 2>/dev/null | sed -n "s/^\(emr[^:]*\):.*/\1/p")

for node in $nodes
do
    node_ip=$(getent hosts $node | awk '{ print $1 }')
    echo "$node  $node_ip"
    ssh -i /home/hadoop/.ssh/id_rsa hadoop@$node_ip \
    "find /mnt/disk1/data/ -mtime +5 -name \"*.data\" -exec rm -v {} \;"
done
