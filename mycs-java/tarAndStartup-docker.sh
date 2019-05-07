#!/bin/bash
#author menard
declare path=/wdata/web/mycs-java-tar/mycs-java
declare ext=*.tar.gz
declare workspace=/wdata/web/mycs-java
# 进入工作空间
cd $workspace
# 找到删除原项目文件
for dir in `find ./ -name "mycs-*" -type d`;
  do
    if [ $dir = "./mycs-static"  ]; then
        continue
    fi
    rm -rf $dir
  done
	

result=(`find $path -name $ext -type f`)

for item in ${result[@]};
  do
    tar -zxvf  $item -C $workspace

  done

#杀死Java进程
/wdata/script/stop-mycs-java.sh

#启动java web应用
/wdata/script/start-mycs-java-web.sh

#docker启动时防止后台退出
tail -f /dev/null
