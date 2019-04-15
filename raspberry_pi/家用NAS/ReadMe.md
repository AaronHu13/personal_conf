#### 家用NAS配置指南

#### 前言
昨天冲动买的3B+到货了，很开心，开始折腾。主要是打算把之前部署在zero上面的那一套服务全部部署到3b+上，实现局域网内文件的共享，流媒体播放等功能

#### 基本配置-zsh,vim,tmux
这几个算是装机必备了，所以在git上面把配置文件给传上去了（主要针对tmux，我把ctrl+b改成了ctrl+a, 然后用v,h可以分割窗口，个人觉得这样用起来更舒服一些）
> https://github.com/Aaron0813/personal_conf

```shell
# zsh
sudo apt-get install zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
chsh -s /usr/bin/zsh

# tmux
sudo apt-get install tmux
rm -rf .tmux
git clone https://github.com/Aaron0813/Personal_ConfigFile.git
ln -s Personal_ConfigFile/tmux/.tmux.conf
cp Personal_ConfigFile/tmux/.tmux.conf.local .
```

#### 硬盘挂载
我的硬盘是NTFS格式，所以需要安装插件才能够实现挂载
```shell
sudo apt-get install ntfs-3g
# 创建一个文件夹，让硬盘挂载在上面
mkdir Netac
# /dev/sda1表示硬盘在系统里面的编号这个可以用 ls /dev/sd* 命令来查看，~/Netac表示要挂载到的文件夹地址
sudo mount /dev/sda1 ~/Netac

# 取消挂载
sudo umount ~/Netac
```
可以写脚本实现自动挂载，但我感觉有的时候我并不想实现硬盘自动挂载，就没实现，参考链接见下面
> https://www.cnblogs.com/mq0036/p/9343862.html

#### Samba
1. 安装
```sh
sudo apt-get install samba samba-common-bin # 主程序
#########################  optional   #####################################
# 如果出现安装不完全，尝试
# update
sudo apt-get update
# 用--fix-missing
sudo apt-get install samba samba-common-bin --fix-missing
###############################################################
sudo apt-get install avahi-daemon # 能够使得一个局域网环境下的设备自动获取到树莓派的服务器
```

2. 配置参数
- 打开/etc/samba/smb.conf配置文件，在最下面增加以下代码：
```
wins support = yes # 同时打开对Win支持

[share]

comment = Root Storage
path = / 
valid users = root # 可访问的用户，samba有独立的用户体系
browseable = yes
public = yes
writable = yes
create mask = 0777
directory mask = 0777

[share]

comment = User Storage
path = /home
valid users = rasp 
browseable = yes
public = yes
writable = yes
create mask = 0777
directory mask = 0777

[share]

comment = Public Storage
path = /home/rasp/Netac/share
valid users = guest 
browseable = yes
public = yes
writable = yes
create mask = 0777
directory mask = 0777
```
鉴于我前两天在在卸载zsh的时候把系统搞崩了，但当时我发现samba的服务依然可以正常启动。所以我就想到下次再出现这种情况，我其实可以通过samba来修改相应的配置文件，从而避免的重装系统这种蠢事，所以我这次在配置的时候，这个代码我是配置了三份，一份给root用，以备不时之需，一份给自己用，方便对整个home文件夹进行管理，一个给室友们用，把相应的移动硬盘里面指定路径的文件分享出去

更新：很奇怪，root的话没办法获取文件目录，这个后面再说好了

- 由于samba有自己独立的用户体系，还需要将root用户增加到samba中
```shell
smbpasswd -a root # 会提示设置密码，需输入两遍
sudo /etc/init.d/samba restart # 重启软件生效
```

- 设置开机自动启动samba，修改/etc/rc.loca，增加如下内容：
```shell
sudo /etc/init.d/samba start
```

#### DLNA
1. 安装
```shell
sudo apt-get install minidlna # 安装主程序
```

2. 设置DLNA
- 打开DLNA的配置文件/etc/minidlna.conf，在末尾添加如下内容：
```shell
media_dir=A,/home/pi/sda1 # A表示自动加载音乐文件，后面是我的PT目录
media_dir=P,/home/pi/sda1 # P表示自动加载图片文件
media_dir=V,/home/pi/sda1 # V表示自动加载视频文件
db_dir=/home/pi/sda1/dlna # 设置DLNA的目录
log_dir=/home/pi/sda1/dlna # 设置DLNA的日志
```
- 重启生效
```shell
/etc/init.d/minidlna restart # 重启软件，配置生效
```

- 后续
按照下面链接的说法，我应该是可以通过ipad访问这个服务器了，但是奇怪的是我只有mac可以访问，ipad并不可以，所以我又继续往下加了FTP
> https://blog.csdn.net/CrazyBusby/article/details/81609017

#### FTP
1. 安装
```shell
sudo apt-get install vsftpd
```
2. 启动
```shell
sudo service vsftpd start
```
3. 修改默认配置
```shell
sudo vi /etc/vsftpd.conf
```
修改文件内容
```shell
# 不允许匿名访问
anonymous_enable=NO
# 可以写入
write_enable=YES
# 设置上传文件掩码
local_umask=022
# 使用utf-8字符集
utf8_filesystem=YES
```
4. 权限设置
- 指定 FTP 用户主目录
```shell
cd /etc/vsftpd/ # 如果没有该文件夹就创建
vi vsftpd.conf
# 添加读取用户配置目录
user_config_dir=/etc/vsftpd/userconf

mkdir userconf   # 如果没有目录自己创建
sudo vi touch fr003    #  这里是创建 fr003 用户的配置文件    
# 添加配置指定用户目录
local_root=/home/rasp

#重启服务
service vsftpd restart
# 注意 /home/rasp 目录的权限
usermod -d /home/rasp rasp    
# 更改用户fr003的主目录为 /home/pi
 

# 指定 FTP 用户访问列表位置
cd /etc/vsftpd/
sudo vi vsftpd.conf
# 修改文件内容
chroot_list_enable=YES

# 启动chroot列表
chroot_list_file=/etc/vsftpd/vsftpd.chroot_list

#指定列表位置
sudo vi /etc/vsftpd/vsftpd.chroot_list
rasp
# 添加用户，一个用户一行
# 这样rasp就只访问它指定的主目录
```



6. 重启ftp服务
```shell
sudo service vsftpd restart
```

7. 参考
> [权限管控]https://blog.csdn.net/pengchengxue110/article/details/54426296
> [FTP配置]https://www.jianshu.com/p/42df944d349d

#### Aria2
1. 安装
```shell
sudo apt install aria2
```
2. 配置文件
```shell
# 1. 创建在home文件夹下创建.aria2文件夹
mkdir .aria2
# 用之前提到的git repo
git clone https://github.com/Aaron0813/Personal_ConfigFile.git
cp Personal_ConfigFile/aria2/aria2.conf .aria2 

# 打开/etc/rc.local ，在 exit 0 之前添加一行命令用于开机启动 Aria2（-D参数后台运行）：
aria2c --conf-path=/home/pi/.aria2/aria2.conf

# 使用以下命令来立即启动 Aria2
aria2c --conf-path=/home/pi/.aria2/aria2.conf -D

# 进入/var/www/html,下载AriaNG-如果链接失效直接去github下载即可
sudo git clone https://github.com/mayswind/AriaNg/releases/download/1.0.0/AriaNg-1.0.0-AllInOne.zip
unzip Aria*

# 在浏览器直接输入http://raspberry_ip/index.html即可
```

#### 后续
全程大概用了两三个小时从头配置Raspberry Pi 3B+，以后打算把稳定的服务都部署在3B+上，毕竟性能更好（zero重装系统就是因为zsh加载autosuggestion和git插件变慢，手贱卸载才废掉的），这样子Zero W就可以用来随便玩了。前两天看到另一个非常有意思的NAS方案，是专门针对raspberry pi设计的，有定制的镜像。本打算部署在3B+上，但是觉得要是这样子的话，这个raspberry pi就没啥别的功能了，所以还是自己定制玩起来比较有意思
> [镜像地址]https://sourceforge.net/projects/openmediavault/files/
> [参考链接]https://www.jianshu.com/p/a4162cf0d2a5
  