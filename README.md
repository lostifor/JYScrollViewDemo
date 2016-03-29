# JYScrollViewDemo

#####需要导入SDWebImage 
通过model封装的循环轮播控件，可传入图片URL数组或者是本地image（传名字数组），使用注意事项如下：

- 1 需要在JYScrollItem中#import "UIImageView+WebCache.h"。
- 2 创建一个JYScrollView对象，需自己设定frame，见demo。
- 3 提供了两个方法，一种是一般要求轮播图，另一种是轮播图带文字描述。
- 4 timeInterval图片切换间隔（不设置则默认为10秒）placeHolder占位图片名字。

####演示图
