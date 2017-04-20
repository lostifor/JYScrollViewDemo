# JYScrollViewDemo

#####需要导入SDWebImage 
通过model封装的循环轮播控件，可传入图片URL数组或者是本地image（传名字数组），使用注意事项如下：

- 1 需要在JYScrollItem中#import "UIImageView+WebCache.h"。
- 2 创建一个JYScrollView对象，需自己设定frame，见demo。
- 3 提供了两个方法，一种是一般要求轮播图，另一种是轮播图带文字描述。
- 4 timeInterval图片切换间隔（不设置则默认为10秒）placeHolder占位图片名字。
- 5 block回调中的参数index即为当前页（pagecontroller.currentpage）

####演示图
![轮播上.gif](http://upload-images.jianshu.io/upload_images/1043061-a7236993fadbbc99.gif?imageMogr2/auto-orient/strip)

![轮播下.gif](http://upload-images.jianshu.io/upload_images/1043061-231cda59d2a0dca7.gif?imageMogr2/auto-orient/strip)
