# zsh
其实这个是oh-my-zsh的配置文件,我就改了两点
1. ys主题->一开始很喜欢powerline主题,但是发现每次都需要进行配置,很麻烦其实.反而是ys主题全平台通用,无需配置,很方便
2. zsh-autosuggestions插件->这个插件真的是巨好用!!!!相当喜欢,其实反倒是git插件用得少.树莓派上出现过插件装多了加载特别慢的情况,所以Raspberry Pi Zero W我直接没有加载插件了(没有zsh-autosuggestions还真的有点不习惯)


# 注意事项
卸载zsh需谨慎,要是卸载的时候没有修改shell,会出现无法登陆的情况,慎重慎重(重装raspberry pi 中)

```shell
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
chsh -s /usr/bin/zsh
```
