### vim插件使用

#### NERDTree插件

```shell
" NERDTree config
map <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
```

第一条是说使用F2键快速调出和隐藏它；
第二条是关闭vim时，如果打开的文件除了NERDTree没有其他文件时，它自动关闭，减少多次按:q!

**如果想打开vim时自动打开NERDTree，可以如下设定**

```shell
autocmd vimenter * NERDTree
```

移动命令：

```shell
ctrl + h    光标向左侧文件移动
ctrl + l    光标向右侧文件移动
ctrl + w    光标向下一个左侧窗口切换
```

