#coding:utf-8
export LANG=UTF-8
export LANGUAGE=UTF-8
yum groupinstall -y "Development tools"
yum install -y sqlite-devel ncurses-devel ncurses-libs zlib-devel mysql-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel openssl-devel
wget https://www.moerats.com/usr/shell/Python3/Python-3.6.4.tar.gz && tar zxvf Python-3.6.4.tar.gz && cd Python-3.6.4
./configure
make&& make install
cd ..
rm -rf Python-3.6.4 Python-3.6.4.tar.gz

