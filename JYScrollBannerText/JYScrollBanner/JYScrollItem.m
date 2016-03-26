//
//  JYScrollItem.m
//  JYScrollBannerText
//
//  Created by 李佳育 on 16/3/24.
//  Copyright © 2016年 李佳育. All rights reserved.
//


#import "JYScrollItem.h"
#import "JYScrollItemModel.h"
#import "UIImageView+WebCache.h"



@interface JYScrollItem()

//@property (nonatomic, weak) UIImageView* imageView;
@property (nonatomic, weak) UIView * titleBkg;
@property (nonatomic, weak) UILabel * lblTitle;
@property (nonatomic, weak) UILabel * lblDesc;
@property (nonatomic, weak) UIView * bgView;
//@property (nonatomic , strong) UIImageView * saveImageView;

@end


@implementation JYScrollItem

- (instancetype)init
{
    if (self = [super init])
    {
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews
{
    
    //    UIView * bg = [[UIView alloc] init];
    //    bg.backgroundColor = [UIColor blackColor];
    //    bg.alpha = 0.5;
    //    [self addSubview:bg];
    //    self.bgView = bg;
    UIImageView * imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UIView * titleBkg = [[UIView alloc] init];
    titleBkg.backgroundColor = [UIColor blackColor];
    titleBkg.alpha = 0.5;
    [self addSubview:titleBkg];
    self.titleBkg = titleBkg;
    
    UILabel * lblTitle = [[UILabel alloc] init];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.numberOfLines = 0;
    lblTitle.font = [UIFont systemFontOfSize:12];
    [self addSubview:lblTitle];
    self.lblTitle = lblTitle;
}


- (void)layoutSubviews
{
    CGFloat itemW = CGRectGetWidth(self.frame);
    CGFloat itemH = CGRectGetHeight(self.frame);
    self.imageView.frame = CGRectMake(0, 0, itemW, itemH);
    
    CGFloat titleH = 35.0;
    CGRect rcTitle = CGRectMake(15, itemH - titleH, itemW - 15 - 60, titleH);
    
    self.lblTitle.frame = rcTitle;
    if (self.data.isNeedTitle) {
        self.titleBkg.frame = CGRectMake(0, itemH - titleH, itemW, titleH);
        self.bgView.frame = CGRectMake(0, itemH - titleH, itemW, titleH);
    } 
    
}

- (void)setData:(JYScrollItemModel *)data
{
    _data = data;
    if (data.isUrl) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.data.imageName] placeholderImage:[UIImage imageNamed:data.placeHolder]];
    } else {
        if (data.image) {
            self.imageView.image = data.image;
        } else {
            
            self.imageView.image = [UIImage imageNamed:self.data.imageName];
        }
    }
    
    //    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:data.imageName]]];
    
    if (data.isNeedTitle) {
        self.lblTitle.text = [NSString stringWithFormat:@"  %@", self.data.title];
        [self.lblTitle sizeToFit];
    }
    
}


@end
