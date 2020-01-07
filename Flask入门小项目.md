[toc]

### 1.项目环境

#### 基本配置

Ubuntu18 +Python3.6.6+ 编辑器Vim8+浏览器Chrome+虚拟工具pyenv+Git version 2.19.1

环境搭建查看[个人笔记](https://www.jianshu.com/p/b152dd92bdea)

使用命令行

```shell
mkdir watchlist
cd watchlist
```

#### 使用Git

`配置个人信息`

```shel
git config --global user.name "yourname"
git config --global user.email "yourEmail"
```

在项目目录下创建一个Git仓库

```shell
git init
# 这会在当前目录下创建一个.git文件夹（隐藏的文件夹，使用command：ls -a查看）
```

 在项目根目录下创建一个.gitignore文件，是用来让Git忽略一些不需要的记录变化的文件

```shell
vim .gitignore
```

写入常见的可忽略文件规则

```shell
*.pyc
*~
__pycache__
.DS_Store
.python-version
```

`:wq 保存退出`

**设置SSH密码**

创建SSH密钥：

```shell
ssh-keygen
# 一直Enter采用默认值，ok之后会在.ssh目录生成id_rsa.pub和id_rsa。前者是可以放到GitHub上的密钥值，后者是私钥
```

查看SSH密钥

```shell
cat ~/.ssh/id_rsa.pub
```

选中并复制输出的内容，访问GitHub的[SSH设置页面](https://github.com/settings/keys)（导航栏头像-Setting-SSH and GPG keys），点击New SSH key，粘贴到Key输入框中，添加Title，最后点击"Add SSH key"

**创建远程仓库**

访问[新建仓库页面](https://github.com/new)（导航栏'+' - New repository）并创建一个仓库。

创建本地仓库，并指定远程仓库的地址

```shell
git remote add origin git@github.com:youruser/repositoryName.git
```

#### 创建虚拟环境Pyenv

虚拟环境是独立于Python全局环境的Python解释器环境，好处如下：

* 保持全局环境的干净
* 指定不同的依赖版本
* 方便记录和管理依赖
* 多个Python版本共存

配置requirement.txt文件管理依赖（目前如此）

```shell
pip install flask==1.0.2
```



### 2.创建Flask程序

#### 编写主页app.py

```python
from flask import Flask
  
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Welcome to My Watcjlist!'
```

执行`flask run`命令，在Chrome中输入http://localhost:5000访问程序

**安装python-dotenv**会产生.flaskenv和.env文件

pip install python-dotenv

编写.flaskenv文件 ,这个文件用来存储Flask命令行系统相关的公开环境变量

```shell
FLASK_APP = filename.py 	# 设置服务器默认启动文件
FLASK_ENV = development		# 开启调试模式（debug）
```

.env文件是用来存储敏感数据，所以不提交进Git仓库

