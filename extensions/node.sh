#!/usr/bin/env bash

data_center_size=$1
unique_string=$2
data_center_name=$3
opscenter_location=$4

echo "Input to node.sh is:"
echo unique_string $unique_string
echo data_center_name $data_center_name
echo opscenter_location $opscenter_location

opscenter_dns_name="opscenter$unique_string.$opscenter_location.cloudapp.microsoftazure.de"
cluster_name="mycluster"
# data_center_size
# data_center_name
public_ip=`curl --retry 10 icanhazip.com`
private_ip=`echo $(hostname -I)`
node_id=$private_ip

echo "Calling addNode.py with the settings:"
echo opscenter_dns_name $opscenter_dns_name
echo cluster_name $cluster_name
echo data_center_size $data_center_size
echo data_center_name $data_center_name
echo public_ip $public_ip
echo private_ip $private_ip
echo node_id $node_id

apt-get update
apt-get -y install unzip python-pip
pip install requests

cd /
wget https://github.com/DSPN/install-datastax-ubuntu/archive/master.zip
unzip master.zip
cd install-datastax-ubuntu-master/bin/lcm

./addNode.py \
--opsc-ip $opscenter_dns_name \
--clustername $cluster_name \
--dcsize $data_center_size \
--dcname $data_center_name \
--pubip $public_ip \
--privip $private_ip \
--nodeid $node_id
