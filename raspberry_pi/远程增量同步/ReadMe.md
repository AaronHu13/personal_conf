### 远程增量同步


缘起:某天晚上我用markdown写作业,写完之后生成pdf文档交了上去.但是离作业截止还有一个小时的时候,忽然发现作业有一道题没写,我就找markdown文件准备重新生成,结果一搜傻眼了,自己大概十分钟前清空了一波回收站,貌似把作业顺带给误删了,所以最后我的作业是这个样子做了修改的.第二天早上写代码,git reset 的时候选择的是hard,结果之前更改的代码也全部丢了,当时很难受.所以我就在想,能不能自己写个脚本,定时同步到远程的服务器上面,然后只做增量备份且不删除服务器那边的文件.经过一番搜索,感觉自己找到了想要的答案--rsync.貌似不难,在此暂时记录一下,有空要把它做掉.很有意思的感觉


![image-20190208172455090](https://raw.githubusercontent.com/Aaron0813/personal_conf/master/raspberry_pi/%E8%BF%9C%E7%A8%8B%E5%A2%9E%E9%87%8F%E5%90%8C%E6%AD%A5/image-20190208172455090.png)



#### Reference

> 1. https://www.cnblogs.com/kevingrace/p/5766139.html
>
> 2. https://www.jianshu.com/p/7e88eaf68022
