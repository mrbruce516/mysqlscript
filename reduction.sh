#!/bin/bash
# 需要安装pv，可以查看进度

pwd=""
database=""
server=""

j=0
for i in `ls -1 *.sql`
do
    bakname_file[j]=$i
    echo "正在处理${bakname_file[j]} "
    # 关闭索引，加快恢复速度
    sed -i '/KEY /s/^/-- /g' ${bakname_file[j]}
    sed -i "s/1代表信创',/1代表信创'/g" ${bakname_file[j]}
    pv ${bakname_file[j]} | mysql -h $server -uroot -p$pwd $database
    if [ $? -eq 0 ]
    then
        echo "已成功还原表${bakname_file[j]}"
	    mv ${bakname_file[j]} over
        j=`expr $j + 1`
    else
        echo "恢复表失败"
        exit 1
    fi
done
