#!/bin/bash

# the default node number is 3
N=${1:-5}

sudo docker network create --driver=bridge hadoop &> /dev/null
# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 9870:9870 \
                -p 19888:19888 \
                -p 10020:10020 \
                -p 9820:9820 \
                --name hadoop-master \
                --hostname hadoop-master \
                myhadoop:v3.1.3 &> /dev/null


# start hadoop slave container
#i=1
#while [ $i -lt $N ]
#do
#	sudo docker rm -f hadoop-slave$i &> /dev/null
#	echo "start hadoop-slave$i container..."
#	sudo docker run -itd \
#	                --net=hadoop \
#	                --name hadoop-slave$i \
#	                --hostname hadoop-slave$i \
#	                myhadoop:v3.1.3 &> /dev/null
#	i=$(( $i + 1 ))
#done

echo "start hadoop-slave1 container..."
sudo docker run -itd -p 8088:8088 -p 9861:9864 --net=hadoop --name hadoop-slave1 --hostname hadoop-slave1 myhadoop:v3.1.3
echo "start hadoop-slave2 container..."
sudo docker run -itd -p 9868:9868 -p 9862:9864 --net=hadoop --name hadoop-slave2 --hostname hadoop-slave2 myhadoop:v3.1.3
echo "start hadoop-slave3 container..."
sudo docker run -itd -p 9863:9864 --net=hadoop --name hadoop-slave3 --hostname hadoop-slave3 myhadoop:v3.1.3
echo "start hadoop-slave4 container..."
sudo docker run -itd -p 9864:9864 --net=hadoop --name hadoop-slave4 --hostname hadoop-slave4 myhadoop:v3.1.3


# get into hadoop master container
sudo docker exec -it hadoop-master bash
