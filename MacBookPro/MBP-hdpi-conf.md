## 解决MBP外接2K显示屏字体太小的问题
**需要开启显示器的hidpi模式，类似于macbook的retina模式 那么就会在图像大小不变的情况下，看起来变的特别清晰**


我们要修改系统目录下/System/Library/Displays/Contents/
Resources/Overrides/，需要将SIP关闭下
>- **关闭System Integrity Protection SIP**
```
# 重启macbook，在开机的时候按command+R进入恢复模式, 在终端输入
srutil disable
```
重启进入系统后，打开终端输入以下命令
>- **开启macbook的hidpi**
```
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool YES
```


执行一下命令获取显示器的值
```
ioreg -l | grep "DisplayVendorID"
ioreg -l | grep "DisplayProductID"  
```
获取显示器的型号
```
ioreg -lw0 | grep IODisplayEDID | sed "/[^<]*</s///" | xxd -p -r | strings -6
```
#### **然后将值填入这个网站进行配置**---[SCALED RESOLUTIONS](https://comsysto.github.io/Display-Override-PropertyList-File-Parser-and-Generator-with-HiDPI-Support-For-Scaled-Resolutions/)

执行下面命令，得到系统文件配置名
```
ioreg -lw0 | grep IODisplayPrefsKey
```
下载[RDM](http://avi.alkalay.net/software/RDM/)更换到1920*1080分辨率
