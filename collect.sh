if [ -z "$1" ]; then
   echo "Must provide folder name as parameter"
   exit 1
fi

mkdir -p $1/status

echo "Loading status of node0"
curl -f http://18.223.239.8:26657/status > $1/status/node0.txt
echo "Loading status of node1"
curl -f http://18.224.153.9:26657/status > $1/status/node1.txt
echo "Loading status of node2"
curl -f http://18.225.37.2:26657/status > $1/status/node2.txt
echo "Loading status of node3"
curl -f http://18.216.154.34:26657/status > $1/status/node3.txt

mkdir -p $1/dump_consensus_state

echo "Loading dump_consensus_state of node0"
curl -f http://18.223.239.8:26657/dump_consensus_state > $1/dump_consensus_state/node0.txt
echo "Loading dump_consensus_state of node1"
curl -f http://18.224.153.9:26657/dump_consensus_state > $1/dump_consensus_state/node1.txt
echo "Loading dump_consensus_state of node2"
curl -f http://18.225.37.2:26657/dump_consensus_state > $1/dump_consensus_state/node2.txt
echo "Loading dump_consensus_state of node3"
curl -f http://18.216.154.34:26657/dump_consensus_state > $1/dump_consensus_state/node3.txt

mkdir -p $1/logs

echo "Extracting logs of node0"
ssh centos@18.223.239.8 "journalctl > log.txt"
echo "Extracting logs of node1"
ssh centos@18.224.153.9 "journalctl > log.txt"
echo "Extracting logs of node2"
ssh centos@18.225.37.2 "journalctl > log.txt"
echo "Extracting logs of node3"
ssh centos@18.216.154.34 "journalctl > log.txt"

echo "Loading logs of node0"
scp centos@18.223.239.8:~/log.txt $1/logs/log-node0.txt
echo "Loading logs of node1"
scp centos@18.224.153.9:~/log.txt $1/logs/log-node1.txt
echo "Loading logs of node2"
scp centos@18.225.37.2:~/log.txt $1/logs/log-node2.txt
echo "Loading logs of node3"
scp centos@18.216.154.34:~/log.txt $1/logs/log-node3.txt

mkdir -p $1/df

echo "Getting df of node0"
ssh centos@18.223.239.8 "df -h" > $1/df/node0.txt
echo "Getting df of node1"
ssh centos@18.224.153.9 "df -h" > $1/df/node1.txt
echo "Getting df of node2"
ssh centos@18.225.37.2 "df -h" > $1/df/node2.txt
echo "Getting df of node3"
ssh centos@18.216.154.34 "df -h" > $1/df/node3.txt
