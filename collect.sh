if [ -z "$1" ]; then
   echo "Must provide folder name as parameter"
   exit 1
fi

mkdir -p $1/status

# echo "Loading status of node0"
# curl -f http://18.223.204.76:26657/status > $1/status/node0.txt
echo "Loading status of node1"
curl -f http://52.15.174.195:26657/status > $1/status/node1.txt
echo "Loading status of node2"
curl -f http://18.222.75.1:26657/status > $1/status/node2.txt
echo "Loading status of node3"
curl -f http://18.223.177.85:26657/status > $1/status/node3.txt

mkdir -p $1/dump_consensus_state

# echo "Loading dump_consensus_state of node0"
# curl -f http://18.223.204.76:26657/dump_consensus_state > $1/dump_consensus_state/node0.txt
echo "Loading dump_consensus_state of node1"
curl -f http://52.15.174.195:26657/dump_consensus_state > $1/dump_consensus_state/node1.txt
# echo "Loading dump_consensus_state of node2"
# curl -f http://18.222.75.1:26657/dump_consensus_state > $1/dump_consensus_state/node2.txt
echo "Loading dump_consensus_state of node3"
curl -f http://18.223.177.85:26657/dump_consensus_state > $1/dump_consensus_state/node3.txt

mkdir -p $1/logs

echo "Extracting logs of node0"
ssh ec2-user@18.223.204.76 "journalctl > log.txt"
echo "Extracting logs of node1"
ssh ec2-user@52.15.174.195 "journalctl > log.txt"
echo "Extracting logs of node2"
ssh ec2-user@18.222.75.1 "journalctl > log.txt"
echo "Extracting logs of node3"
ssh ec2-user@18.223.177.85 "journalctl > log.txt"

echo "Loading logs of node0"
scp ec2-user@18.223.204.76:~/log.txt $1/logs/log-node0.txt
echo "Loading logs of node1"
scp ec2-user@52.15.174.195:~/log.txt $1/logs/log-node1.txt
echo "Loading logs of node2"
scp ec2-user@18.222.75.1:~/log.txt $1/logs/log-node2.txt
echo "Loading logs of node3"
scp ec2-user@18.223.177.85:~/log.txt $1/logs/log-node3.txt