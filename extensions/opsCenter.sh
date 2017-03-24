#!/usr/bin/env bash

username=$1
password=$2

echo "Input to node.sh is:"
echo username $username
echo password $password

public_ip=`curl --retry 10 icanhazip.com`
cluster_name="mycluster"

echo "Calling setupCluster.py with the settings:"
echo public_ip $public_ip
echo cluster_name $cluster_name
echo username $username
echo password $password

apt-get update
apt-get -y install unzip python-pip
pip install requests

cd /
wget https://github.com/DSPN/install-datastax-ubuntu/archive/master.zip
unzip master.zip
cd install-datastax-ubuntu-master/bin/

# Overide install default version
export OPSC_VERSION='6.0.8'

./os/install_java.sh
./opscenter/install.sh
./opscenter/start.sh
sleep 1m

#KLUDGE!
sed -ie 's/PasswordAuthenticator/AllowAllAuthenticator/g' ./lcm/setupCluster.py
sed -ie 's/5.0.7/5.0.5/g' ./lcm/setupCluster.py

./lcm/setupCluster.py \
--opsc-ip $public_ip \
--clustername $cluster_name \
--user $username \
--datapath "/mnt/cassandra"
