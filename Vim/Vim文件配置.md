### Vim文件配置

**Vim之Error detected while processing BufRead Auto commands for "*.py":E518: Unknown option: set**

`au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
`

> 报错如：
> Error detected while processing BufRead Auto commands for “*.py”:
> E518: Unknown option: set

处理如下：

`au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
`

#### YouCompleteMe自动补全的安装配置与使用

安装依赖

vim 版本需大于7.3584, 并支持 python2脚本
可以通过 vim —version 查看 vim 版本
vim 安装 sudo apt-get install vim
Python 安装 sudo apt-get install python-dev libxml2-dev libxslt-dev
安装 git (sudo apt-get install git)
安装 gcc (sudo apt-get install gcc)
安装 cmake (sudo apt-get install cmake)

下载之前配置cdn：

查询下面两个最近的服务器地址：

```shell
x.x.x.x github.global-ssl.fastly.net
x.x.x.x github.com
```

添加到下面文件中

`sudo vim /etc/hosts`

在～/.vim/bundle目录下git

```shellshe l
git clone --recursive git://github.com/Valloric/YouCompleteMe
```

git下来后使用`git submodule update --init --recursive`命令检查完整性

确认完整性ok，在输入

```shell
python3 install.py --clang-completer
```

.vimrc中加入:

```shell
" YouCompleteMe
set runtimepath+=~/.vim/bundle/YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1           " 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释与字符串中的内容也用于补全
let g:syntastic_ignore_files=[".*\.py$"]
let g:ycm_seed_identifiers_with_syntax = 1                  " 语法关键字补全
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  " 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用.
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0                           " 禁用语法检查
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |            " 回车即选中当前项
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|     " 跳转到定义处
"let g:ycm_min_num_of_chars_for_completion=2                 " 从第2个键入字符就开始罗列匹配项
```