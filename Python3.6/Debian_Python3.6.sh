#coding:utf-8
export LANG=UTF-8
export LANGUAGE=UTF-8
apt-get update -y
apt-get install -y make gcc libncurses5-dev libncursesw5-dev bzip2 libmysqlclient-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev ca-certificates
wget https://www.moerats.com/usr/shell/Python3/Python-3.6.4.tar.gz && tar zxvf Python-3.6.4.tar.gz && cd Python-3.6.4
./configure
make&& make install
cd ..
rm -rf Python-3.6.4 Python-3.6.4.tar.gz