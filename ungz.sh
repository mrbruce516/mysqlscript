#!/bin/bash

# 自动解压文件到bakfile
j=0
for i in `ls -1`
do
    workdir_list[j]=$i
    #echo ${workdir_list[j]}
    gzip -d ${workdir_list[j]}
    if [ $? -eq 0 ]
    then
	echo "已成功解压${workdir_list[j]}"
        sqlbak=`ls -d *.sql`
        mv $sqlbak ../bakfile
        j=`expr $j + 1`
    else
        echo "解压文件失败"
        exit 1
    fi
done
