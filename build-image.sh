#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t myhadoop:v2.0 .

echo ""