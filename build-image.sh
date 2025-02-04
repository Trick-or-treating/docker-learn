#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t myhadoop:v3.1.3 .

echo ""