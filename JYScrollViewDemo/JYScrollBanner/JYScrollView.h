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

//时间间隔
@property (nonatomic, assign) double timeInterval;

//stop timer
- (void)stop;


/**
 *  不带图片描述的轮播图
 *
 *  @param array       图片url数组数组 或者image名数组
 *  @param type        JYImageURLType url类型  JYImageImageType图片类型
 *  @param placeHolder 占位图名字  占位图需自己加入项目 或者传空不要占位图
 *  @param sel         点击轮播图的方法（block中写点击需要实现的内容） index为当前第几个（从0开始）
 */
- (void)bannerWithArray:(NSArray *)array imageType:(JYImageType)type placeHolder:(NSString *)placeHolder tapAction:(void(^)(NSInteger index))sel;

/**
 *  带描述的轮播图
 *
 *  @param array       图片url数组数组 或者image名数组
 *  @param titleArr    图片下方描述数组 （数量应与图片url数组相同）
 *  @param type        JYImageURLType url类型  JYImageImageType图片类型
 *  @param placeHolder 占位图名字  占位图需自己加入项目 或者传空不要占位图
 *  @param sel         点击轮播图的方法（block中写点击需要实现的内容） index为当前第几个（从0开始）
 */
- (void)bannerWithArray:(NSArray *)array titleArr:(NSArray *)titleArr imageType:(JYImageType)type placeHolder:(NSString *)placeHolder tapAction:(void(^)(NSInteger index))sel;
@end
