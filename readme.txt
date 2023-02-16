在进行测试之前需要先跑prepare128.sh准备数据集（直接跑就行）
其中，run.sh需要原生的rocksdb6和rocksdb7的db_bench进行测试

rocksdb7-layer版本的下载编译命令如下：

git clone https://github.com/iiEpoch/layer-rocksdb7.git

chmod -R 777 *

make db_bench -j
