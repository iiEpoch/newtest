#!/bin/bash

read -p "test_path:" test_path

read -p "report_path:" report_path
mkdir ${report_path}

# WAL state(true or false)
disable_wal="false"

value=128


data_path="/mnt/nvme5"


for dataset in {200,400}
do	
	
	echo "创建测试目录${test_path}"
	mkdir ${test_path}

	cp -r ${data_path}/${value}B/${dataset}G/* ${test_path}
	echo "复制${data_path}/${value}B/${dataset}G到${test_path}"

	sleep 10
	
	echo "进行测试写${dataset}G-value${value}-Disable_Wal-${disable_wal}"

	./overwrite.sh ${test_path} ${dataset} ${value} ${report_path} ${disable_wal}	

	sleep 5

	rm -rf ${test_path}
	echo "进行直接测试写${dataset}G-value${value}-Disable_Wal-${disable_wal}"
	mkdir ${test_path}
	./write.sh ${test_path} ${dataset} ${value} ${report_path} ${disable_wal}
	rm -rf ${test_path}
	
	echo "本次测试完成删除test目录"
	sleep 10

done
