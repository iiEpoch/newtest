#!/bin/bash
#iostat启动
iostat -x 5 |tee ${4}/iostat-Dwrite_layer_Dataset_${2}G_Value_${3}_DisWal_${5}.txt &

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
declare -i data=${2}\*1024\*1024\*1024\/${3}
numactl -C 0-31 ./db_bench --benchmarks="fillrandom,stats,levelstats" \
--db=${1}/128B \
--db_paths_1=${1}/128B \
--db_paths_2=${6}/128B \
--value_size=${3} --key_size=16 --enable_pipelined_write=true \
--disable_wal=${5} \
--writes=15000000 \
--threads=96 \
--enable_write_thread_adaptive_yield=false \
--disable_auto_compactions=false \
--compression_type=snappy \
--max_background_jobs=8 \
--allow_concurrent_memtable_write=true \
--batch_size=1 \
--use_direct_io_for_flush_and_compaction=true \
--target_file_size_base=67108864 \
--sync=false \
--report_interval_seconds=5 \
--report_file=${4}/Dwrite_layer_Dataset_${2}G_Value_${3}_DisWal_${5}.csv \
| tee ${4}/Dwrite_layer_Dataset_${2}G_Value_${3}_DisWal_${5}.txt \

ps -ef | grep iostat | grep -v grep | awk '{print $2}' | xargs kill -9
