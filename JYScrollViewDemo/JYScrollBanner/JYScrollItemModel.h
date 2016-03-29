//
//  JYScrollItemModel.h
//  JYScrollBannerText
//
//  Created by 李佳育 on 16/3/24.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface JYScrollItemModel : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString * imageUrls;
@property (nonatomic, copy) NSString * imageName;
@property (nonatomic, copy) NSString * title;
//@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) UIImage * image;
@property (nonatomic, assign, getter=isUrl) BOOL url;


//Add  placeHolder.....
@property (nonatomic, copy) NSString * placeHolder;
@property (nonatomic, assign, getter=isNeedTitle) BOOL needTitle;



@end
