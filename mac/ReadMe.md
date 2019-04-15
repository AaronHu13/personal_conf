### Mac Config

```
本文章主要简单记录一些在经过亲身实践后,用起来比较舒服的配置.主要是方便自己折腾电脑,另外也是分享一些比较好的软件出来
```

1. Mount NTFS disk on Mac

   ```bash
   #之前一直听说Mac不能挂载NTFS的硬盘,但是最近在玩树莓派,把我的移动硬盘都挂上去了,就突然想起来,Mac好歹也是个Unix系统啊,那凭啥不能以Unix的方式挂载NTFS的硬盘呢?一搜,嘿,还真的可以.以下是详细操作(在Terminal里面操作)
   
   ############################################
   
   #1. 找到 Device Node
   diskutil info /Volumes/YOUR_NTFS_DISK_NAME 
   #Device Node:              /dev/disk1s1
   
   #2. 弹出你的硬盘
   hdiutil eject /Volumes/YOUR_NTFS_DISK_NAME
   #"disk1" unmounted.
   #"disk1" ejected.
   
   #3. 创建一个目录，稍后将mount到这个目录 
   sudo mkdir /Volumes/MYHD
   
   #4. 将NTFS硬盘 挂载 mount 到mac
   sudo mount_ntfs -o rw,nobrowse /dev/disk1s1 /Volumes/MYHD/
   ```

   >https://blog.csdn.net/elaine_bao/article/details/79276947
   > https://github.com/Sailiy/ntfsx


2. [NCDU--磁盘空间分析](https://www.jianshu.com/p/6b3f1eaa6a7c)

   ```bash
   brew install ncdu 
   ncdu /you_dir
   
   # On Linux
   # 看这一级目录的结果
   du -sh *
   ```

   

3. [微信客户端插件](https://github.com/Sunnyyoung/WeChatTweak-macOS)

   ```
   相当好用的一个针对Mac版微信的插件,主要解决了我的这几个痛点:
   1. 避免登录手机验证
   2. 可以配合Alfred进行联系人快速查找(Alfred真的是神器,谁用谁知道)
   3. 防撤回
   ```

   

4. [AppCleaner](http://link.zhihu.com/?target=https%3A//freemacsoft.net/appcleaner/)—超级好用的卸载工具

   

5. [IINA](http://link.zhihu.com/?target=https%3A//lhc70000.github.io/iina/) **（先进的 macOS 视频播放器）**

6. [Typora](http://link.zhihu.com/?target=https%3A//typora.io/) **（Markdown 写作利器）**

7. Magnet(一个App Store的付费软件)

   ```
   主要解决多个窗口同屏的问题,这个在windows下解决的很好,但是Mac相对来说弱一些
   ```

   

8. Alfred, Dash: 两个大神器,一向自诩从不会在软件上花钱的我,都心甘情愿的掏腰包买正版,自己体会吧



#### 终端

1. ITerm2

2. [zsh](https://segmentfault.com/a/1190000012786464)

   ```
   oh-my-zsh + autosuggestions + solarized配色,个人觉得虽然agnoster比较帅气,但还是ys主题比较通用,不用折腾,且显示的信息比较全,且autosuggestion真的是让你爱上使用terminal
   ```

3. vim

   ```
   一开始我还兴致勃勃的给vim装了个spf13-vim,后来发现插件装多了反而vim加载的比较慢,本身我使用vim就是临时编辑一下文件,快速简洁才是我最关心的地方,还是雪阳老哥说的对,宇宙编辑器VScode那么好用,干嘛非要折腾vim,所以我现在vim唯一的配置就是装了一个solarized配色主题
   ```

4. [extract](http://link.zhihu.com/?target=https%3A//github.com/robbyrussell/oh-my-zsh/tree/master/plugins/extract)**一个命令解压所有文件**

   ```
   真的是相当好用了,一个x加上压缩包,就可以解压缩任何类型的文件,简直是个神器
   ```

   

5. [tmux](https://my.oschina.net/am313/blog/865915)

   ```
   个人相当喜欢的一个功能,很多时候挂载树莓派需要执行一些任务,不能中断,这时候用tmux真的是相当好用,而且可以把屏幕刷刷刷划成好多份,节省空间还装逼,很喜欢
   ```

   > https://github.com/Aaron0813/personal_conf/tree/master/tmux

#### Reference

> 1. https://zhuanlan.zhihu.com/p/48207191
