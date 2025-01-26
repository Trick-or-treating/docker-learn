#!/bin/bash

# the default node number is 3
N=${1:-4}

sudo docker network create --driver=bridge hadoop &> /dev/null
# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 9091:9090 \
                -p 9001:9000 \
                --name hadoop-master \
                --hostname hadoop-master \
                myhadoop:v2.0 &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                myhadoop:v2.0 &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hadoop-master bash
