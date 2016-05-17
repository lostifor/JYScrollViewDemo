//
//  JYScrollView.m
//  JYScrollBannerText
//
//  Created by 李佳育 on 16/3/24.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import "JYScrollView.h"
#import "JYScrollItem.h"

@interface JYScrollView() <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView* scrollView;


@property (nonatomic, weak) JYScrollItem* leftItem;
@property (nonatomic, weak) JYScrollItem* midItem;
@property (nonatomic, weak) JYScrollItem* rightItem;
@property (nonatomic, assign) CGRect leftFrame;
@property (nonatomic, assign) CGRect midFrame;
@property (nonatomic, assign) CGRect rightFrame;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic,   copy) void(^tap)(NSInteger index);
@property (nonatomic,   copy) void(^setPageControl)();

@end

@implementation JYScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubViews];
    }
    return self;
}

- (void)bannerWithArray:(NSArray *)array imageType:(JYImageType)type placeHolder:(NSString *)placeHolder tapAction:(void(^)(NSInteger index))sel {
    NSMutableArray * tempArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        JYScrollItemModel * model = [[JYScrollItemModel alloc] init];
        id obj = array[i];
        if ([obj isKindOfClass:[UIImage class]]) {
            model.image = array[i];
        } else {
            model.imageName = array[i];
            model.placeHolder = placeHolder;
        }
        model.needTitle = NO;
        model.index = i;
        model.url = type == JYImageURLType;
        [tempArray addObject:model];
    }
    self.datas = tempArray;
    //加手势以及点击事件
    UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto)];
    [self addGestureRecognizer:tap];
    self.tap = sel;
}

- (void)bannerWithArray:(NSArray *)array titleArr:(NSArray *)titleArr imageType:(JYImageType)type placeHolder:(NSString *)placeHolder tapAction:(void(^)(NSInteger index))sel {
    NSMutableArray * tempArray = [NSMutableArray array];
    
    if (titleArr.count) {
        __weak __typeof(&*self)weakSelf = self;
        _setPageControl = ^() {
            CGPoint center = weakSelf.pageControl.center;
            center.x = [UIScreen mainScreen].bounds.size.width * 0.9;
            weakSelf.pageControl.center = center;
        };
    }
    
    for (int i = 0; i < array.count; i ++) {
        JYScrollItemModel * model = [[JYScrollItemModel alloc] init];
        id obj = array[i];
        
        if ([obj isKindOfClass:[UIImage class]]) {
            //images
            model.image = array[i];
        } else {
            //urls
            model.imageName = array[i];
            model.placeHolder = placeHolder;
        }
        
        if (titleArr) {
            model.needTitle = YES;
            model.title = titleArr[i];
        } else {
            model.needTitle = NO;
        }
        model.index = i;
        model.url = type == JYImageURLType;
        [tempArray addObject:model];
    }
    self.datas = tempArray;
    //加手势以及点击事件
    UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto)];
    [self addGestureRecognizer:tap];
    self.tap = sel;

}

- (void)tapPhoto {
    
    !self.tap?:self.tap(self.pageControl.currentPage);
    
}

- (void)initSubViews
{
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIPageControl* pageControl = [[UIPageControl alloc] init];
    pageControl.hidesForSinglePage = YES;
    pageControl.numberOfPages = 1;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.userInteractionEnabled = NO;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    JYScrollItem* leftItem = [[JYScrollItem alloc] init];
    [self.scrollView addSubview:leftItem];
    self.leftItem = leftItem;
    
    JYScrollItem* midItem = [[JYScrollItem alloc] init];
    [self.scrollView addSubview:midItem];
    self.midItem = midItem;
    
    JYScrollItem* rightItem = [[JYScrollItem alloc] init];
    [self.scrollView addSubview:rightItem];
    self.rightItem = rightItem;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat itemW = CGRectGetWidth(self.frame);
    CGFloat itemH = CGRectGetHeight(self.frame);
    self.scrollView.frame = CGRectMake(0, 0, itemW, itemH);
    
    self.leftFrame = CGRectMake(0, 0, itemW, itemH);
    self.midFrame = CGRectMake(itemW, 0, itemW, itemH);
    self.rightFrame = CGRectMake(itemW * 2, 0, itemW, itemH);
    
    self.leftItem.frame = self.leftFrame;
    self.midItem.frame = self.midFrame;
    self.rightItem.frame = self.rightFrame;
}

- (void)setDatas:(NSArray *)datas
{
    _datas = datas;
    
    int index = 0;
    for (JYScrollItemModel * data in self.datas)
    {
        data.index = index;
        index ++;
    }
    
    CGFloat itemW = CGRectGetWidth(self.frame);
    CGFloat itemH = CGRectGetHeight(self.frame);
    CGFloat pageControlW = 22.0;
    CGFloat pageControlH = 35.0;
    NSUInteger count = self.datas.count;
    self.pageControl.numberOfPages = count;
    self.pageControl.currentPage = 0;
    self.pageControl.frame = CGRectMake(itemW - pageControlW * count , itemH - pageControlH, pageControlW * count, pageControlH);
    
    //pageControl locationSetting......
    CGPoint center = self.pageControl.center;
    center.x = [UIScreen mainScreen].bounds.size.width * 0.5;
    self.pageControl.center = center;
    if (_setPageControl) {
        _setPageControl();
    }
    
    
    if (count > 0)
    {
        self.leftItem.data = [self.datas lastObject];
        if (count > 1)
        {
            self.midItem.data = [self.datas firstObject];
            self.rightItem.data = [self.datas objectAtIndex:1];
            
            self.scrollView.contentSize = CGSizeMake(itemW * 3, itemH);
            self.scrollView.contentOffset = CGPointMake(itemW, 0);
        }
        else
        {
            self.scrollView.contentSize = CGSizeMake(itemW, itemH);
            self.midItem.frame = self.leftFrame;
        }
    }
    
    [self startTimer];
}

- (void)startTimer
{
    if (self.datas.count < 2)
    {
        return;
    }
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [self.timer fire];
}

- (void)setTimeInterval:(double)timeInterval {
    _timeInterval = timeInterval;
    [self endTimer];
    [self startTimer];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [self setNeedsDisplay];
}

- (void)endTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollPage
{
    CGFloat itemW = CGRectGetWidth(self.frame);
    [self.scrollView setContentOffset:CGPointMake(itemW * 2, 0) animated:YES];
}

- (void)stop
{
    [self endTimer];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat itemW = CGRectGetWidth(self.frame);
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x == 0 || offset.x == itemW * 2)
    {
        self.scrollView.contentOffset = CGPointMake(itemW, 0);
        __weak JYScrollItem * midItem = self.midItem;
        __weak JYScrollItem * leftItem = self.leftItem;
        __weak JYScrollItem * rightItem = self.rightItem;
        
        if (offset.x == 0)
        {
            self.midItem = leftItem;
            self.leftItem = midItem;
            
            self.midItem.frame = self.midFrame;
            self.leftItem.frame = self.leftFrame;
        }
        else
        {
            self.midItem = rightItem;
            self.rightItem = midItem;
            
            self.midItem.frame = self.midFrame;
            self.rightItem.frame = self.rightFrame;
        }
        
        NSInteger count = self.datas.count;
        NSInteger curindex = self.midItem.data.index;
        NSInteger previndex = curindex - 1;
        NSInteger nextindex = curindex + 1;
        
        if (previndex < 0)
        {
            previndex = count - 1;
        }
        if (nextindex >= count)
        {
            nextindex = 0;
        }
        
        self.leftItem.data = [self.datas objectAtIndex:previndex];
        self.rightItem.data = [self.datas objectAtIndex:nextindex];
        self.pageControl.currentPage = curindex;
        
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(scrollPage) userInfo:nil repeats:YES];;
    }
    return _timer;
}



@end
