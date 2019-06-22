#!/usr/bin/python  
# coding=UTF8 
 
import os 
import sys 
from IPy import IP 

f1=open("./IP-segment.txt","r")
f2=open("./IP-result.txt",'a+') 
 
line1=f1.readlines() 
iplist = ""
#获取f1文件中的每行数据
for m in line1: 
	ips = str(m).split("-")
        #获取-前的开始IP
	ips1 = str(ips[0]).split(".")
        #获取-后的开始IP
	ips2 = str(ips[1]).split(".")
        #对IP地址进行判断，并将相应结果输入到f2中。
	if(ips1[0]==ips2[0] and ips1[1]==ips2[1] and ips1[2]==ips2[2]):
		for x in range(int(ips1[3]),int(ips2[3])+1):
			iplist = str(ips1[0])+'.'+str(ips1[1])+'.'+str(ips1[2])+'.'+str(x)
			print >> f2,"%s" %iplist
	else:
		for j in range(int(ips1[3]),256):
			iplist = str(ips1[0])+'.'+str(ips1[1])+'.'+str(ips1[2])+'.'+str(j)
			print >> f2,"%s" %iplist
		for i in range(int(ips1[2])+1,int(ips2[2])):
			for j in range(0,256):
				iplist = str(ips1[0])+'.'+str(ips1[1])+'.'+str(i)+'.'+str(j)
				print >> f2,"%s" %iplist
		for j in range(0,int(ips2[3])):
			iplist = str(ips1[0])+'.'+str(ips1[1])+'.'+str(ips2[2])+'.'+str(j)
			print >> f2,"%s" %iplist
            