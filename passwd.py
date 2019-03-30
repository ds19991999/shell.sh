#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: c.k
# Time: 2019/3/30
# Email: cva.engineer.ding@gmail.com
# Function: passwd system
# usage: python3 passwd.py

import os
passwd_infor = []

def print_menu():
    os.system("cls")  # linux系统此处改为clear
    print("=" * 50)
    print("   密码账号管理系统 V0.01")
    print(" 1. 添加一个账号")
    print(" 2. 删除一个账号")
    print(" 3. 修改一个账号")
    print(" 4. 查询一个账号")
    print(" 5. 显示所有的账号")
    print(" 6. 退出系统")
    print(" 7. 显示菜单")
    print("=" * 50)


def add_passwd():
    """添加账号"""
    passwd_net = input("请输入账号注册官网：")
    passwd_name = input("请输入账号用户名：")
    passwd_passwd = input("请输入账号密码：")
    passwd_email = input("请输入账号密保邮箱：")
    passwd_phone = input("请输入账号密保手机号：")

    new_passwd = {}
    new_passwd["net"] = passwd_net
    new_passwd["name"] = passwd_name
    new_passwd["passwd"] = passwd_passwd
    new_passwd["email"] = passwd_email
    new_passwd["phone"] = passwd_phone

    global passwd_infor
    passwd_infor.append(new_passwd)
    save_passwd()
    print_menu()

def del_passwd():
    """删除账号"""
    global passwd_infor
    del_passwdtemp = input("请输入要删除的账号信息：")
    find_flag, passwd = find_passwd(del_passwdtemp)
    if find_flag == 1:
        print("以上是查找到的账号信息！")
        for i in passwd:
            print("%s\t%s\t%s\t%s\t%s" % (i["net"], i["name"], i["passwd"], i["email"], i["phone"]))
            flag = input("你想要删除这个账号吗？(y/n)：")
            if flag in ["y","Y","yes","Yes","YES"]:
                passwd_infor.remove(i)
        save_passwd()
        print_menu()


def revise_passwd():
    """修改账号"""
    global passwd_infor
    find_passwdtemp = input("请输入要修改的账号信息：")
    find_flag, passwd = find_passwd(find_passwdtemp)
    if find_flag == 1:
        print("以上是查找到的账号信息！")
        for i in passwd:
            print("%s\t%s\t%s\t%s\t%s" % (i["net"], i["name"], i["passwd"], i["email"], i["phone"]))
            flag = input("你想要修改这个账号吗？(y/n)：")
            if flag in ["y","Y","yes","Yes","YES"]:
                add_passwd()
                passwd_infor.remove(i)
        save_passwd()
        print("恭喜，账号修改成功！")
        print_menu()

def find_passwd(find_temp):
    """查找账号"""
    global passwd_infor
    find_flag = 0
    passwd = []
    for temp in passwd_infor:
        find_list = [temp["net"], temp["name"], temp["passwd"], temp["email"], temp["phone"]]
        if find_temp in find_list:
            print("%s\t%s\t%s\t%s\t%s" % (temp["net"], temp["name"], temp["passwd"], temp["email"], temp["phone"]))
            find_flag = 1
            passwd.append(temp)
    if find_flag == 0:
        os.system("cls") # linux系统此处改为clear
        print("没有找到账号信息，请重新操作.")
        print_menu()
    return find_flag, passwd

def show_passwd():
    """显示所有账户"""
    global passwd_infor
    print("官网\t用户名\t密码\t邮箱\t手机号")
    for temp in passwd_infor:
        print("%s\t%s\t%s\t%s\t%s" % (temp["net"], temp["name"], temp["passwd"], temp["email"], temp["phone"]))

def exit_system():
    """退出系统"""
    os.system(exit())

def save_passwd():
    """保存密码文件"""
    f = open("passwd.json", "w")
    f.write(str(passwd_infor))
    f.close()


def load_passwd():
    """加载密码文件"""
    global passwd_infor
    try:
        f = open("passwd.json")
        passwd_infor = eval(f.read())
        f.close()
    except Exception:
        pass

def main():
    """主程序"""
    load_passwd()
    print_menu()
    while True:
        try:
            num = int(input("请输入操作序号："))
            if num == 1:
                add_passwd()
            elif num == 2:
                del_passwd()
            elif num == 3:
                revise_passwd()
            elif num == 4:
                find_temp = input("输入要查找的的账号信息：")
                find_passwd(find_temp)
            elif num == 5:
                show_passwd()
            elif num == 6:
                exit_system()
            elif num == 7:
                print_menu()
            else:
                print("输入有误，请重新输入.")
        except Exception:
            print("输入有误，请重新输入.")

if __name__ == "__main__":
    main()
	