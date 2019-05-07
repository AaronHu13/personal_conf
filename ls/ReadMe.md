### Mac ls Solarized主题
Solarized主题很好看,但有个问题就是在该主题下,ls配色相当单调.折腾了好一阵子,总算找到了解决方案.在此自己mark一下

1. [下载对应主题](https://github.com/seebi/dircolors-solarized)
2. 在.zshrc或者.bash_profile里面添加
	```shell
	eval `gdircolors /path/to/dircolorsdb`
	```
	注意是gdircolors而不是该项目readme里面的dircolors.后者是针对常见的Linux系统,但是mac是基于FreeBSD的(说实话这两者区别我还是没搞懂)."/path/to/dircolorsdb"指的是你想使用的主题文件,像我的就是"/Users/XXX/codes/personal_conf/dircolors-solarized/dircolors.256dark"
3. 如果没有gdircolors,用以下命令安装
	```shell
	brew install coreutils
	```
4. 根据官网提示,继续添加以下三个里面的一个到.zshrc或者.bash_profile里面
	```shell
	export TERM=xterm-256color        # for common 256 color terminals (e.g. gnome-terminal)
	export TERM=screen-256color       # for a tmux -2 session (also for screen)
	export TERM=rxvt-unicode-256color # for a colorful rxvt unicode session
	```
5. source .zshrc/.bash_profile