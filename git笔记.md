[toc]

## Git

Git是用C语言开发的，最早用于Linux和Unix系统上跑，因为太过优秀，又被人移植到Windows和Mac系统上[^个人用Linux用的多，所以以Linux为主]

为什么要使用git？

原因只有一个 它是真的优秀

### 安装Git

#### 在Linux上安装Git

先在终端中输入<font color=#ff00ff>git</font>,看看系统有没有安装Git

```shell
$ git
The program 'git' is currently not installed. You can install it by typing:
sudo apt-get install git
```

这里大致的意思是告诉你Git没有安装，你可以尝试用`sudo apt-get install git`命令来安Git

如你的Linux  是Ubuntu 或者Debian就可以使用上面这条命令[^我使用的是Ubuntu18]

如果是其他优秀的Linux 发行版，可以源码安装

1.下载git

```shell
wget https://www.kernel.org/pub/software/scm/git/git-2.21.0.tar.gz
```

2.安装依赖

```shell
yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel asciidoc
yum install  gcc perl-ExtUtils-MakeMaker
```

3.解压

```shell
sudo tar -zxvf git-2.21.0.tar.gz
```

4.编译安装（这里要进入git的解压目录哦）

```shell
sudo ./configure --prefix=/usr/local/git
sudo make && make install
```

5.添加环境变量

```shell
echo 'export PATH="/usr/local/git/bin:$PATH" ' >> /etc/profile
```

6.查看是否安装ok

```shell
git --version
```





#### 在Mac OS X上安装Git

如果你正在使用Mac做开发，有两种安装Git的方法。

一是安装homebrew，然后通过homebrew安装Git，具体方法请参考homebrew的文档：http://brew.sh/。

第二种方法更简单，也是推荐的方法，就是直接从AppStore安装Xcode，Xcode集成了Git，不过默认没有安装，你需要运行Xcode，选择菜单“Xcode”->“Preferences”，在弹出窗口中找到“Downloads”，选择“Command Line Tools”，点“Install”就可以完成安装了。



#### 在Windows上安装Git

在Windows上使用Git，可以从Git官网直接[下载安装程序](https://git-scm.com/downloads)，（网速慢的同学请移步[国内镜像](https://pan.baidu.com/s/1kU5OCOB#list/path=%2Fpub%2Fgit)），然后按默认选项安装即可。

安装完成后，在开始菜单里找到“Git”->“Git Bash”，蹦出一个类似命令行窗口的东西，就说明Git安装成功



### 配置Git仓库

配置自己的个人信息，以后在提交代码到版本仓库的时候进行记录

```shell
git config --global user.name "yourname"
git config --global user.email "youremail"
```

#### 创建版本库

<font color=#00ff00>版本库</font>又名仓库（repository）,可以理解为它是一个目录，这个目录又被Git管理起来，每个文件的修改、删除，Git都能跟踪，以便任何时刻都可以追踪历史，或者在将来某个时刻可以“还原”。

先创建一个空目录

```shell
mkdir hellogit
cd hellogit
```

再使用`git init`命令把这个目录变成Git可以管理的仓库

```shell
git init
已初始化空的 Git 仓库于 /home/luyao/pyWorkStation/hello/.git/
```

使用`ls -a`可以看到当前目录下多了一个`.git`	目录，这个目录是Git来跟踪管理版本库的



**编写`.gitignore`文件**

当我们再开发的时候有些文件不用记录变化的，创建这个文件来写上自己要想忽略的文件，比如我学的python Web开发就有些文件不必记录

在Vim编辑器上写入常见的可忽略的文件规则：

```shell
vim .gitignore
```

输入`i`进入编辑模式

```bash
*.pyc
*~
__pycache__
.DS_Store
.python-version
```

最后`Esc`退出编辑模式，并输入`:wq`保存退出



### 使用GitHub

#### 设置SSH密码

创建SSH密钥，一路Enter默认设置即可：

```shell
ssh-keygen
# 一直Enter采用默认值，ok之后会在.ssh目录生成id_rsa.pub和id_rsa。前者是可以放到GitHub上的密钥值，后者是私钥
```

查看SSH密钥

```shell
cat ~/.ssh/id_rsa.pub
```

选中并复制输出的内容，访问GitHub的[SSH设置页面](https://github.com/settings/keys)（导航栏头像-Setting-SSH and GPG keys），点击New SSH key，粘贴到Key输入框中，添加Title，最后点击"Add SSH key"

#### 创建远程仓库

访问[新建仓库页面](https://github.com/new)（导航栏'+' - New repository）并创建一个仓库。

创建本地仓库，并指定远程仓库的地址

```shell
git remote add origin git@github.com:youruser/repositoryName.git
```

关联远程仓库之后，写个REANME.md文件

```shell
vim README.md

# 这是一个h1标题
## 这是一个h2标题
### 这是一个h1标题
```

`:wq`保存退出

执行

```shell
git add README.md
git commit -m "上传一份README.md文件"
git push -u origin master
```

git add  <file> 添加一个文件,也可以使用`git add .`	提交全部文件(推荐这条命令，可以偷懒)

git commit -m "..."  `-m`后面输入的本次提交的说明

git push -u origin master  `-u`参数会将推送的目标仓库和分支设为默认值，之后提交到GitHub使用`git push`就行