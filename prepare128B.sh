#!/bin/bash

path="/mnt/nvme5"

path_old="/mnt/nvme5/4096B"

rm -rf ${path_old}

value_size=128

mkdir ${path}/${value_size}B

for dataset in {200,400}
do	
	echo "创建${dataset}G-${value_size}B数据集"
	./writedata.sh ${path} ${dataset} ${value_size}
	sleep 10
done
