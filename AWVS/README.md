# AWVS 批量扫描

破解`AWVS`下载：[AWVS](https://github.com/ds19991999/AWVS/tree/master/awvs)，文末有相关脚本链接。

## 说明

`AWVS`在`windows`平台有命令行版本，它是`GUI`自带的，但是并没多少人注意到它，实际上可以直接利用这个`wvs_console.exe`文件写个批处理实现`AWVS`的批量扫描。

![](https://image.creat.kim/picgo/20190622134126.png)

## Common Usage

```shell
/Scan 设置扫描的URL eg: wvs_console /Scan http://www.baidu.com/
/Scanlist 设置扫描文件 eg: wvs_console Scanlist C:\list.txt 
/Profile 指定扫描策略 eg: /Profile ws_default 应用profiles下的ws_default策略文件
```

采用`/Scanlist`，列表中站点的扫描是同时进行的，无法设置扫描的优先级，如果需要先对某一些站点进行检查，采用这种方式不是很适合。

eg:

```shell
wvs_console /Scan http://testphp.vulnweb.com  /Profile ws_default /SaveFolder c:\scanResults\ /Save
```

## 脚本使用
![](https://image.creat.kim/picgo/20190622180044.png)
以管理员方式运行脚本即可，`list.txt`为扫描的`URL`，一行一个，运行结果保存在`C:\scanResults`文件夹。**特别注意，使用之前请先配置环境变量。**

## 开启 `web` 服务 进行批量扫描

`AWVS`自带的`web`服务也可以进行批量扫描。

![](https://image.creat.kim/picgo/20190622143016.png)

输出模板选择受影响的项目

![](https://image.creat.kim/picgo/20190622143222.png)

点`OK`就可以直接后台扫描了。

## 本文附加文件下载
https://pan.creat.kim/share/tA3hE1W7
