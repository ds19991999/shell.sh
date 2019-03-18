#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# ====================================================
# Description:PyOne 一键脚本 for Debian 8+ 、CentOS 7
# Author:MOERATS
# Site:moerats.com
# ====================================================

#fonts color
Red="\033[31m" 
Font="\033[0m"
Blue="\033[36m"

#root permission
root(){
        if [[ $EUID -ne 0 ]]; then
        echo "${Red}Error:请使用root运行该脚本！"${Font} 1>&2
        exit 1
        fi
}

#check system
system(){
        if [ -f /etc/redhat-release ]; then
        release="centos"
    elif cat /etc/issue | grep -Eqi "debian"; then
        release="debian"
    elif cat /etc/issue | grep -Eqi "ubuntu"; then
        release="ubuntu"
    elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
        release="centos"
    elif cat /proc/version | grep -Eqi "debian"; then
        release="debian"
    elif cat /proc/version | grep -Eqi "ubuntu"; then
        release="ubuntu"
    elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
        release="centos"
    fi
}

#check version
version(){
	if [[ -s /etc/redhat-release ]]; then
	 version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
	else
	 version=`grep -oE  "[0-9.]+" /etc/issue | cut -d . -f 1`
	fi
	bit=`uname -m`
	if [[ ${bit} = "x86_64" ]]; then
		bit="64"
	else
		bit="32"
	fi
    if [[ "${release}" = "centos" && ${version} -ge 7 ]];then
        echo -e "${Blue}当前系统为CentOS ${version}${Font} "
    elif [[ "${release}" = "debian" && ${version} -ge 8 ]];then
        echo -e "${Blue}当前系统为Debian ${version}${Font} "
    else
        echo -e "${Red}脚本不支持当前系统，安装中断!${Font} "
        exit 1
    fi
	for EXE in grep cut xargs systemctl ip awk
	do
		if ! type -p ${EXE}; then
			echo -e "${Red}系统精简厉害，脚本自动退出${Font}"
			exit 1
		fi
	done
}

#enter info
enter(){
    if [ "${num}" = "2" ]; then
    stty erase '^H' && read -p "请输入你的PyOne域名信息(如:pyone.moerats.com):" py_domain
    fi
    stty erase '^H' && read -p "请输入你的Aria2密钥:" pass
}

#install repo
repo(){
    if [ "${release}" = "centos" ]; then
        rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/mongodb.repo -P '/etc/yum.repos.d/'
    else
        apt update -y
        apt install curl -y
        if [ "${version}" = "8" ]; then
        curl https://www.dotdeb.org/dotdeb.gpg | apt-key add -
        echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
        echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
        apt update -y
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
        echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
        else
        curl https://www.mongodb.org/static/pgp/server-3.6.asc | apt-key add -
        echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
        fi
    fi
}

#install depend(Redis、Mongodb)
depend(){
echo -e "${Blue}开始安装Redis、Mongodb等依赖${Font}"
    if [ "${release}" = "centos" ]; then
        yum -y install mongodb-org make git gcc crontabs lsof unzip
        wget http://download.redis.io/releases/redis-5.0.2.tar.gz
        tar zxvf redis-5.0.2.tar.gz && rm -rf redis-5.0.2.tar.gz
        cd redis-5.0.2
        make
    if [ $? -ne 0 ]; then
        echo -e "${Red}Redis安装失败，请重新检查！${Font}"
        exit 1
    fi
        cp src/redis-server src/redis-cli /usr/local/bin
        cd ..
        rm -rf redis-5.0.2
        sysctl -w vm.overcommit_memory=1
        echo 512 > /proc/sys/net/core/somaxconn
        echo never > /sys/kernel/mm/transparent_hugepage/enabled
        echo "net.core.somaxconn= 1024" >> /etc/sysctl.conf
        sysctl -p
    else
        apt update -y
        apt-get install -y mongodb-org redis-server make git cron build-essential python-dev lsof unzip
    fi
    if [ $? -ne 0 ]; then
        echo -e "${Red}Mongodb等依赖安装失败，请重新检查！${Font}"
        exit 1
    else
        echo -e "${Blue}Mongodb等依赖安装成功！${Font}"
    fi
}

#install aria2
aria2(){
echo -e "${Blue}开始安装Aria2...${Font}"
wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/aria2-1.34.0-linux-${bit}.tar.gz
tar zxvf aria2-1.34.0-linux-${bit}.tar.gz
rm -rf aria2-1.34.0-linux-${bit}.tar.gz
cd aria2-1.34.0-linux-${bit}
make install
 EXEC="$(command -v aria2c)"
    if [[ -n ${EXEC} ]]; then
        echo -e "${Blue}Aria2安装成功！${Font}"
    else
        echo -e "${Red}Aria2安装失败！${Font}"
        exit 1
    fi
cd ..
rm -rf aria2-1.34.0-linux-${bit}
mkdir "/root/.aria2" && mkdir /root/Download
wget -N --no-check-certificate https://www.moerats.com/usr/shell/Aria2/dht.dat -P '/root/.aria2/'
wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/aria2.conf -P '/root/.aria2/'
wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/trackers-list-aria2.sh -P '/root/.aria2/'
touch /root/.aria2/aria2.session
chmod +x /root/.aria2/trackers-list-aria2.sh
chmod 777 /root/.aria2/aria2.session
sed -i "s/rpc-secret=/rpc-secret=${pass}/g" /root/.aria2/aria2.conf
echo -e "${Blue}开始设置trackers-list自动更新！${Font}"
echo "0 3 */7 * * /root/.aria2/trackers-list-aria2.sh
*/5 * * * * systemctl restart aria2" > /root/bt.cron
crontab bt.cron
rm -rf bt.cron
}

#install pyone
pyone(){
echo -e "${Blue}正在安装pip！${Font}"
    if [ "${release}" = "centos" ]; then
        yum install -y python-pip
        EXEC="$(command -v pip)"
        if [[ -z ${EXEC} ]]; then
	wget https://bootstrap.pypa.io/get-pip.py
        python get-pip.py
        fi
    else
        apt-get -y install python-pip
    fi
    EXEC="$(command -v pip)"
    if [[ -n ${EXEC} ]]; then
    echo -e "${Blue}pip安装成功！${Font}"
    else
    echo -e "${Red}pip安装失败！${Font}"
    exit 1
    fi
cd /root
if [ "${choice}" = "2" ]; then
git clone https://github.com/abbeyokgo/PyOne.git
cd PyOne
cp self_config.py.sample self_config.py
else
wget wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/PyOne-3.0.zip
unzip PyOne-3.0.zip && rm -rf PyOne-3.0.zip
cd PyOne
cp config.py.sample config.py
fi
pip install -r requirements.txt
}

#install caddy
caddy(){
echo -e "${Blue}正在安装Caddy！${Font}"
curl https://getcaddy.com | bash -s personal
EXEC="$(command -v caddy)"
if [[ -n ${EXEC} ]]; then
echo -e "${Blue}Caddy安装成功！${Font}"
else
echo -e "${Red}Caddy安装失败！${Font}"
exit 1
fi
mkdir /root/.caddy
wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/caddy.conf -P '/root/.caddy/'
sed -i "s/moerats.com/${py_domain}/g" /root/.caddy/caddy.conf
}

#check domain
domain(){
    EXEC="$(command -v bc)"
    if [[ -z ${EXEC} ]]; then
    if [ "${release}" = "centos" ]; then
        yum -y install bc
    else
        apt install bc -y
    fi
    fi
    domain_ip=`ping ${py_domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
    local_ip=`curl http://whatismyip.akamai.com`
    echo -e "域名dns解析IP：${domain_ip}"
    echo -e "本机IP: ${local_ip}"
    sleep 2
    if [[ $(echo ${local_ip}|tr '.' '+'|bc) -eq $(echo ${domain_ip}|tr '.' '+'|bc) ]];then
        echo -e "${Blue}域名dns解析IP与本机IP匹配${Font}"
        sleep 2
    else
        echo -e "${Red}域名dns解析还未生效，请稍后再试！${Font}"
        exit 1
    fi
}

#open firewall
firewall(){
    if [ "${release}" = "centos" ]; then
        firewall-cmd --zone=public --add-port=6800/tcp --permanent
        firewall-cmd --zone=public --add-port=34567/tcp --permanent
        firewall-cmd --zone=public --add-port=80/tcp --permanent
        firewall-cmd --zone=public --add-port=443/tcp --permanent
        firewall-cmd --reload
    fi
}

#set start up
start(){
        echo -e "${Blue}正在为相关应用设置开机自启！${Font}"
        wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/aria2.service -P '/etc/systemd/system/'
        if [ "${num}" = "2" ]; then
        wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/caddy.service -P '/etc/systemd/system/'
        systemctl start caddy
        systemctl enable caddy
        fi
        wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/pyone.service -P '/etc/systemd/system/'
    if [ "${release}" = "centos" ]; then
        wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/redis-server.service -P '/etc/systemd/system/'
    fi
        EXEC="$(command -v gunicorn)"
        sed -i "s#gunicorn#${EXEC}#g" /etc/systemd/system/pyone.service
        systemctl start redis-server aria2 mongod pyone 
        systemctl enable redis-server aria2 mongod pyone
}

#Select version
pyoneversion(){
echo -e "———————————————————————————————————————"
echo -e "${Blue}请选择PyOne版本，输入1或2即可！${Font}"
echo -e "${Blue}1、安装PyOne 3.0${Font}"
echo -e "${Blue}2、安装PyOne 4.0${Font}"
echo -e "———————————————————————————————————————"
while :; do echo
	read -p "请选择： " choice
	if [[ ! $choice =~ ^[1-2]$ ]]; then
		echo -e "${Red}输入错误，请重新输入正确的数字！${Font}"
	else
		break	
	fi
done
}

#Complete info
info(){
    if [ -z "${py_domain}" ]; then
        local_ip=`curl http://whatismyip.akamai.com`
        echo -e "———————————————————————————————————————"
        echo -e "${Blue}PyOne安装完成！${Font}"
        echo -e "${Blue}PyOne访问地址：http://${local_ip}:34567${Font}"
        echo -e "${Blue}Aria2密匙：${pass}${Font}"
        echo -e "${Blue}PyOne后台密码：PyOne${Font}"
        echo -e "———————————————————————————————————————"
    else
        echo -e "———————————————————————————————————————"
        echo -e "${Blue}PyOne安装完成！${Font}"
        echo -e "${Blue}PyOne访问地址：https://${py_domain}${Font}"
        echo -e "${Blue}Aria2密匙：${pass}${Font}"
        echo -e "${Blue}PyOne后台密码：PyOne${Font}"
        echo -e "———————————————————————————————————————"
    fi
}

#start menu
main(){
root
system
version
clear
echo -e "———————————————————————————————————————"
echo -e "${Blue}PyOne一键脚本 for Debian 8+ 、CentOS 7${Font}"
echo -e "${Blue}1、使用IP访问${Font}"
echo -e "${Blue}2、使用域名访问(请提前解析好域名并生效)${Font}"
echo -e "———————————————————————————————————————"
read -p "请输入数字 [1-2]:" num
case "$num" in
    1)
    use_ip
    ;;
    2)
    use_domain
    ;;
    *)
    clear
    echo -e "${Blue}请输入正确数字 [1-2]${Font}"
    sleep 2s
    main
    ;;
    esac
}

use_ip(){
enter
pyoneversion
repo
depend
aria2
pyone
firewall
start
info
}

use_domain(){
enter
pyoneversion
domain
repo
depend
aria2
pyone
caddy
firewall
start
info
}
main
