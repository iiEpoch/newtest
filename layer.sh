#!/bin/bash

read -p "report_path:" report_path

mkdir ${report_path}

#data_path_ssd
path_ssd="/mnt/sda/128"

#data_path_pmem
path_pmem="/mnt/pmem0/128"

mkdir ${path_ssd}

mkdir ${path_pmem}

value_size=128

# WAL state(true or false)
disable_wal="false"

value=128

for dataset in {200,400}
do	
	mkdir ${path_ssd}

	mkdir ${path_pmem}
	
	echo "创建${dataset}G-${value_size}B数据集"
	./writelayer.sh ${path_ssd} ${path_pmem} ${dataset} ${value_size}
	sleep 10
	
	echo "进行分层测试写${dataset}G-value${value}-Disable_Wal-${disable_wal}"
	./overwrite_layer.sh ${path_ssd} ${dataset} ${value} ${report_path} ${disable_wal} ${path_pmem}
	
	
	sleep 10

	rm -rf ${path_ssd}
	rm -rf ${path_pmem}
	
	mkdir ${path_ssd}
	mkdir ${path_pmem}
	
	echo "进行直接分层测试写${dataset}G-value${value}-Disable_Wal-${disable_wal}"
	./write_r.sh ${path_ssd} ${dataset} ${value} ${report_path} ${disable_wal} ${path_pmem}
	
	rm -rf ${path_ssd}
	rm -rf ${path_pmem}
	#删除数据
	sleep 5
done

