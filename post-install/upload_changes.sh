#!/bin/bash


master_node="whoit-ambari-privil-01.whogib.ptec"
cluster_name="who_italy_kafka"
ta_ims_pkey="/var/lib/jenkins/ims_ta_keys/ta_ims.ci_prod"

scp -i ${ta_ims_pkey} ams-hbase-log4j.json ta_ims.ci@${master_node}:/tmp/
scp -i ${ta_ims_pkey} ams-site.json ta_ims.ci@${master_node}:/tmp/
scp -i ${ta_ims_pkey} kafka-broker.json ta_ims.ci@${master_node}:/tmp/

ssh -i ${ta_ims_pkey} ta_ims.ci@${master_node} "sudo /var/lib/ambari-server/resources/scripts/configs.py --user=admin --password=admin --port=8080 --action=set --host=${master_node} --cluster=${cluster_name} --config-type=ams-hbase-log4j --file=/tmp/ams-hbase-log4j.json"
ssh -i ${ta_ims_pkey} ta_ims.ci@${master_node} "sudo /var/lib/ambari-server/resources/scripts/configs.py --user=admin --password=admin --port=8080 --action=set --host=${master_node} --cluster=${cluster_name} --config-type=ams-site --file=/tmp/ams-site.json"
ssh -i ${ta_ims_pkey} ta_ims.ci@${master_node} "sudo /var/lib/ambari-server/resources/scripts/configs.py --user=admin --password=admin --port=8080 --action=set --host=${master_node} --cluster=${cluster_name} --config-type=kafka-broker --file=/tmp/kafka-broker.json"
