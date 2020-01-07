[toc]

## 第一章 初入Web开发

### 入门经书

#### Flask

pass

#### Flask与HTTP

pass

#### 模版

==模版引擎作用是读取并执行模版中的特殊语法标记，并根据传入的数据将变量替换为实际值，输出最终的HTML页面==这个过程也叫==渲染（rendering）==

##### 基本用法

Flask默认使用Jinja2模版引擎

###### 1.创建模版

Jinja2里常见的三种定界符：

(1)语句

比如if判断、for循环等

```html
{%...%}
```

(2)表达式

比如字符串、变量、函数调用等

```html
{{...}}
```

(3)注释

```html
{#...#}
```

Jinja2支持使用 <font color=#ff0000 size=5>"."</font>获取变量的属性

<font color=#00ffff size=3>for example</font>

user字典中的username键值通过 <font color=#ff0000 size=5>"."</font>获取，即user.username，在效果上等同于user['username']

###### **基本语法**

Jinja2并不支持所有的Python语法，它适用于写输出控制相关的逻辑操作

Jinja2支持的Python对象有<font color=#ff00ff size=3>String、List、Dict、tuple、int、float、bool</font>

也支持基本的运算符号（+、-、*、/）比较符号（==、!=）逻辑符号（and、or、not和“()”）以及in、is、None

控制结构：if和for

==if==

```html
{% if ...%}
    ...
{% else %}
    ...
{% endif %}
# 需要添加结束标签
```

==for==

```html
{% for ... %}
    ...
{% endfor %}
```



**常用的Jinja2 for循环特殊变量**

| <font color=#dd00ff size=4>变量名</font> | <font color=#dd00ff size=4>说明</font> |
| :--------------------------------------- | :------------------------------------- |
| loop.index                               | 当前迭代数（从1开始计数）              |
| loop.index()                             | 当前迭代数（从0开始计数）              |
| loop.revindex                            | 当前反向迭代数（从1开始计数）          |
| loop.revindex()                          | 当前反向迭代数（从0开始计数）          |
| Loop.first                               | 如果是最后一个元素，则为Ture           |
| Loop.last                                | 如果是最后一个元素，则为Ture           |
| Loop.previtem                            | 上一个迭代的条目                       |
| Loop.nextitem                            | 下一个迭代的条目                       |
| Loop.length                              | 序列包含的元素数量                     |



==渲染一个模版，就是执行模版中的代码，并传入所有的在模版中使用的变量，渲染后的结果，就是返回给客户端的HTML响应==

在视图函数中渲染模版，不直接使用Jinja2提供的函数，而是使用Flask提供的渲染函数<font color=#00ffff>rander_template()</font>

```python
from flask import Flask,render_template
...
@app.route('watchlist')
def watchlist():
    return render_template('watchlist.html',user=user,movies=movies)
```

在<font color=#00ffff>rander_template()</font>函数中，先以传入模板的文件名作为参数，Flask会在程序根目录下templates文件家中寻找模板文件，另外还以关键字参数的形式传入模板中使用的变量值，以user为例：左边是变量名，右边是传入的对象

*Flask还提供了一个render_template_string()函数用来渲染模版字符串*



#####  辅助工具

###### 1.上下文

模版上下文包含很多变量，调用render_template()函数时要手动传入的变量以及Flask默认传入的变量

除了在渲染中传入变量，也可以在模板中定义变量，使用<font color=#00dd00>set</font>标签：

```html
{% set navigation = [('/','home'),('/about','About')] %}
```

也可以将一部分模版数据定义为变量，使用set和endset标签声明开始和结束：

```html
{% set navigation %}
    <li><a herf='/'>Home</a>
    <li><a herf='/about'>About</a>
{% endset %}
```

2.Flask内置上下文变量

**标准模板全局变量**

| <font color=#00ff00 size=4>变量</font> | <font color=#00ff00 size=4>说明</font>         |
| -------------------------------------- | :--------------------------------------------- |
| config                                 | 当前的配置对象                                 |
| request                                | 当前的请求对象，在已激活的请求环境下可用       |
| session                                | 当前的会话对象，在已激活的请求环境下可用       |
| g                                      | 与请求绑定的全局变量，在已激活的请求环境下可用 |

3.自定义上下文

Flask提供了<font color=#00ffaa>app.context_processor</font>装饰器,用来注册模板上下文处理函数

模板上下文处理函数需要返回一个包含变量键值对的字典

```python
@app.context_processor
def inject_foo():
    foo = 'I am foo.'
    return dict(foo=foo) # 等同于return{'foo': foo}
```

当调用<font color=#00ffff>render_template()</font>函数渲染任意一个模板时，==所用使用<font color=#00ffaa>app.context_processor</font>装饰器注册的模板上下文处理函数（包括Flask内置的上下文处理函数）都会被执行，这些函数的返回值会被添加模板中，因此可在模板中直接使用foo变量



直接方法调用，传入模版上下文处理函数：

```python
def inject_foo():
    foo = 'I am foo'
    return dict(foo=foo)
app.context_processor(inject_foo)
```

使用lambda可以简化：

```python
app.context_processor(lambda: dict(foo='I am foo'))
```



###### **全局对象**

1.Jinja2常用内置模板全局函数

| <font color=#00ddff>函数</font>      | <font color=#00ddff>说明</font>  |
| ------------------------------------ | -------------------------------- |
| range([start,]stop,[step])           | 和Python中的range()用法相同      |
| lipsum(n=5,html=True,min=20,max=100) | 生成随机文本，可用于测试填充页面 |
| dict(**items)                        | 和Python中的dict()用法相同       |

2.Flask内置模板全局函数

| <font color=#00ddff>函数</font> | <font color=#00ddff>说明</font> |
| ------------------------------- | ------------------------------- |
| url_for()                       | 用于生成URL的函数               |
| get_flasjed_messages()          | 用于获取flash消息的函数         |

==Flask处理把g、session、config、request对象注册为上下文变量，也将它们设为全局变量，因此可以全局使用==

###### **过滤器**

在Jinja2中，过滤器(filter)是一些可以用来修改和过滤变量值的特殊函数：

```html
{{ name | title }}
{{ movies | length}}
```

name变量的值标题化，相当于Python里调用name.title()函数

使用length获取movies列表的长度，相当于Python中调用len(movies)

另外一种用法是将过滤器作用于一部分模板数据，使用filter标签和endfilter声明和结束

```html
{% filter upper %}
    This text becomes uppercase
{% endfilter %}
```

使用upper过滤器将一段文字转换为大写