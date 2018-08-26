@echo off
cd ./
echo "准备初始化仓库..."
git init
echo "准备初始化仓库...OK"

echo "添加远程仓库..."
git remote add origin https://github.com/ds19991999/useful-file.git
echo "添加远程仓库...OK"

echo "开始提交本地文件..."
git add . 
git commit -m "auto commit"
echo "开始提交本地文件...OK"

echo "最后强制push到远程仓..."
git push -u origin master -f
echo "最后强制push到远程仓...OK"
pause