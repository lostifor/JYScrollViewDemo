//
//  ViewController.m
//  JYScrollViewDemo
//
//  Created by 李佳育 on 16/3/29.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "ViewController.h"
#import "JYScrollView.h"

@interface ViewController ()
@property (nonatomic, strong) JYScrollView * jyScrollView;
@property (nonatomic, strong) JYScrollView * jy2ScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self initBanner];
}
- (void)initBanner {
    /**
     *  simulation data
     */
    // photo URLs array
    NSArray * array = @[@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1212/27/c0/16922592_1356570394404.jpg",@"http://p9.qhimg.com/t01665b2df63f2dc61b.jpg",@"http://b.hiphotos.baidu.com/zhidao/pic/item/d833c895d143ad4b18e853b981025aafa50f0680.jpg"];
    // photo title array
    NSArray * titleArr = @[@"photo0  aaaaaaaaaaaa",@"photo1  bbbbbbbbbbbb",@"photo2    cccccccccccccc"];
    /**
     加载演示类型2  图 + 描述
     */
    /**
     set UI frame,JYScrollview's pageControl is depend on the screen's width,if you want to make a different one you could click JYScrollView.m to change the size or something.
     */
    _jyScrollView = [[JYScrollView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 230)];
    /**
     *  the array's count must equals to the titleArr's
     *  loadScrollViewData
     */
    [_jyScrollView bannerWithArray:array titleArr:titleArr imageType:JYImageURLType placeHolder:@"placeholderImage.jpg" tapAction:^(NSInteger index) {
        NSLog(@"11111click   NO.%ld",index);
    }];
    _jyScrollView.timeInterval = 1;
    [self.view addSubview:_jyScrollView];
    
    
    
    /**
     加载演示类型1  图
     */
    _jy2ScrollView = [[JYScrollView alloc] initWithFrame:CGRectMake(0, 350, [UIScreen mainScreen].bounds.size.width, 230)];
    [_jy2ScrollView bannerWithArray:array imageType:JYImageURLType placeHolder:nil tapAction:^(NSInteger index) {
        NSLog(@"22222click   NO.%ld",index);
    }];
    _jy2ScrollView.timeInterval = 2;
    [self.view addSubview:_jy2ScrollView];
    
    /**
     *  or you can set the pageControl
     *
     CGPoint center =_jy2ScrollView.pageControl.center;
     center.x = 350;
     _jy2ScrollView.pageControl.center = center;
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
