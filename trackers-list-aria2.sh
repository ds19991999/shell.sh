#!/bin/bash
#适用本仓库的aria2脚本安装
PATH=/root/.aria2/aria2.conf
service aria2 stop
list=`wget -qO- https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt|awk NF|sed ":a;N;s/\n/,/g;ta"`
if [ -z "`grep "bt-tracker" ${PATH}`" ]; then
    sed -i '$a bt-tracker='${list} ${PATH}
    echo add......
else
    sed -i "s@bt-tracker.*@bt-tracker=$list@g" ${PATH}
    echo update......
fi
service aria2 start
