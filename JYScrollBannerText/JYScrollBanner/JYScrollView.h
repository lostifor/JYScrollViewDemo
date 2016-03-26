//
//  JYScrollView.h
//  JYScrollBannerText
//
//  Created by 李佳育 on 16/3/24.
//  Copyright © 2016年 李佳育. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JYImageType) {
    JYImageURLType = 0, // 传url
    JYImageImageType // 传图片
};

#import <UIKit/UIKit.h>
#import "JYScrollView.h"
#import "JYScrollItem.h"
#import "JYScrollItemModel.h"
@interface JYScrollView : UIView

//添加的模型数据 model data
@property (nonatomic, strong) NSArray * datas;

//pageControl
@property (nonatomic, weak) UIPageControl * pageControl;

//占位图
//@property (nonatomic, strong) NSString * placeHolder;


//stop timer
- (void)stop;

//load data method
- (void)bannerWithArray:(NSArray *)array imageType:(JYImageType)type placeHolder:(NSString *)placeHolder tapAction:(void(^)(NSInteger index))sel;
//with desc
- (void)bannerWithArray:(NSArray *)array titleArr:(NSArray *)titleArr imageType:(JYImageType)type placeHolder:(NSString *)placeHolder tapAction:(void(^)(NSInteger index))sel;
@end
