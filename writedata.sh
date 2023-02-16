 #!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
declare -i data=${2}\*1024\*1024\*1024\/${3}
./db_bench --benchmarks="fillseq,stats,levelstats" \
--db=${1}/${3}B/${2}G \
--value_size=${3} --key_size=16 --enable_pipelined_write=true \
--num=${data}  \
--threads=1 \
--enable_write_thread_adaptive_yield=false \
--disable_auto_compactions=false \
--compression_type=snappy \
--max_background_jobs=72 \
--allow_concurrent_memtable_write=true \
--batch_size=1 \
--use_direct_io_for_flush_and_compaction=true \
--target_file_size_base=67108864 \
--sync=false \
