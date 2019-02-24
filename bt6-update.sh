#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8

if [ ! -d /www/server/panel/BTPanel ];then
	echo "============================================="
	echo "错误, 5.x不可以使用此命令升级!"
	echo "5.9平滑升级到6.0的命令：curl http://download.bt.cn/install/update_to_6.sh|bash"
	exit 0;
fi

public_file=/www/server/panel/install/public.sh
if [ ! -f $public_file ];then
	wget -O $public_file http://download.bt.cn/install/public.sh -T 5;
fi
. $public_file

download_Url=$NODE_URL
setup_path=/www
version=$(curl -Ss https://www.bt.cn/api/panel/get_version)
if [ "$version" = '' ];then
	version='6.8.8'
fi
wget -T 5 -O /tmp/panel.zip $download_Url/install/update/LinuxPanel-${version}.zip
dsize=`du -b task.py|awk '{print $1}'`
if [ $dsize -lt 10240 ];then
	echo "获取更新包失败，请稍后更新或联系宝塔运维"
	exit;
fi
unzip -o /tmp/panel.zip -d $setup_path/server/ > /dev/null
rm -f /tmp/panel.zip
cd $setup_path/server/panel/
check_bt=`cat /etc/init.d/bt`
if [ "${check_bt}" = "" ];then
	rm -f /etc/init.d/bt
	wget -O /etc/init.d/bt $download_Url/install/src/bt6.init -T 10
	chmod +x /etc/init.d/bt
fi
#pip install flask_sqlalchemy
#pip install itsdangerous==0.24
echo "====================================="

/etc/init.d/bt start
echo "已成功升级到[$version]${Ver}";


