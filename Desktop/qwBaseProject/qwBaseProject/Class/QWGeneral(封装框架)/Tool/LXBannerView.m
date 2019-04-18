//
//  LXBannerView.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/4/16.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LXBannerView.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface LXBannerView() <UIScrollViewDelegate>

///是否有计时器
@property (nonatomic ,assign) BOOL  hasTimer;
///计时器时间
@property (nonatomic ,assign) NSUInteger interval;
///背景图片
@property (nonatomic ,strong) UIImage *placeHolder;
///图片数组
@property (nonatomic ,strong) NSArray *imageArray;
///轮播图
@property (nonatomic ,strong) UIScrollView *wheelScrollView;
///页面配置
@property (nonatomic ,strong) UIPageControl *wheelPageControl;

///计时器
@property (nonatomic ,strong) NSTimer *timer;
///图片的Index
@property (nonatomic ,assign) NSUInteger  currentImageIndex;

///轮播图的三个基本图片控件
@property (nonatomic ,strong) UIImageView *image1;
@property (nonatomic ,strong) UIImageView *image2;
@property (nonatomic ,strong) UIImageView *image3;

///图片数量
@property (nonatomic ,assign) NSUInteger  imageNum;
///遮罩层
@property (nonatomic ,strong) UIImageView *mask;
///判断是否是本地数据
@property (nonatomic ,assign) BOOL  isLocal;


@end

@implementation LXBannerView

#pragma mark - Lazy

- (UIScrollView *)wheelScrollView{
    if (!_wheelScrollView) {
        _wheelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _wheelScrollView.bgColor(kWhiteColor);
        _wheelScrollView.pagingEnabled = YES;
        _wheelScrollView.delegate = self;
        _wheelScrollView.showsHorizontalScrollIndicator = NO;
        _wheelScrollView.showsVerticalScrollIndicator = NO;
        
        ///点击方法
        [_wheelScrollView ys_tapGesture:^(UIGestureRecognizer *ges) {
            
        }];
        
        // 使用3个UIImageView，
        _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _image3 = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _image2.image = self.placeHolder;
        
        for (UIImageView *imageView in @[_image1, _image2, _image3]) {
            [_wheelScrollView addSubview: imageView];
        }
        
        [_wheelScrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        _wheelScrollView.scrollEnabled = YES;
        _wheelScrollView.contentSize = CGSizeMake(3 * self.frame.size.width, self.frame.size.height);
    }
    return  _wheelScrollView;
}

- (UIPageControl *)wheelPageControl{
    if (!_wheelPageControl) {
        _wheelPageControl = [[UIPageControl alloc] init];
        [_wheelPageControl setBackgroundColor:[UIColor clearColor]];
        _wheelPageControl.currentPage = 0;
        _wheelPageControl.numberOfPages = self.imageNum;
    }
    return _wheelPageControl;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.mask = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.wheelScrollView];
        [self addSubview:self.wheelPageControl];
        [self addSubview:self.mask];
        self.wheelScrollView.scrollEnabled = NO;
    }
    return self;
}

#pragma mark - Life Cycle

#pragma mark - Private

- (void)setupWithArray:(NSArray *)array{
    self.wheelScrollView.scrollEnabled  = YES;
    self.mask.hidden = YES;
    self.imageArray = array;
    self.imageNum = self.imageArray.count;
    self.currentImageIndex = 0;
    
    if (self.imageNum == 1) {
        self.wheelScrollView.hidden = YES;
        self.wheelScrollView.scrollEnabled = NO;
    }
    [self qw_config];
}

- (void)setupWithLocalArray:(NSArray *)array{
    self.isLocal = YES;
    self.wheelScrollView.scrollEnabled = YES;
    self.mask.hidden = YES;
    self.imageNum = self.imageArray.count;
    self.currentImageIndex = 0;
    
    if (self.imageNum == 1) {
        self.wheelScrollView.hidden = YES;
        self.wheelScrollView.scrollEnabled = NO;
    }
    [self qw_config];
}
///初始化
- (void)qw_config{
    self.wheelPageControl.pageIndicatorTintColor = kWhiteColor;
    self.wheelPageControl.currentPageIndicatorTintColor = kBlackColor;
    CGPoint p = CGPointMake(self.frame.size.width * 0.5, 0.92 * self.frame.size.height);
    self.wheelPageControl.center = p;
    
    if (self.hasTimer) {
        [self setupTimer];
    }
    [self updateImage];
    
}

- (void)updateImage{
    self.imageNum = (int)self.imageArray.count;
    self.wheelPageControl.numberOfPages = self.imageNum;
    
    [self updateScrollImage];
}

- (void)updateScrollImage{
    int left;
    int right;
    
    ///计算页数
    int page = self.wheelScrollView.contentOffset.x / self.wheelScrollView.frame.size.width;
    if (page == 0) {
        // %限定当前索引不越界；
        self.currentImageIndex = (self.currentImageIndex + self.imageNum - 1) % self.imageNum;
    }else if(page == 2)
    {
        // 计算当前图片索引
        self.currentImageIndex = (self.currentImageIndex + 1) % self.imageNum;
    }
    
    // 当前图片左右索引
    left = (int)(self.currentImageIndex + self.imageNum - 1) % self.imageNum;
    right = (int)(self.currentImageIndex + 1) % self.imageNum;
    
    // 更换UIImage
    if (self.isLocal)
    {
        self.image1.image = [UIImage imageNamed:self.imageArray[left]];
        self.image2.image = [UIImage imageNamed:self.imageArray[self.self.currentImageIndex]];
        self.image3.image = [UIImage imageNamed:self.imageArray[right]];
    }
    else
    {
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:self.imageArray[left]]  placeholderImage:self.placeHolder];
        [self.image2 sd_setImageWithURL:[NSURL URLWithString:self.imageArray[self.currentImageIndex]] placeholderImage:self.placeHolder];
        [self.image3 sd_setImageWithURL:[NSURL URLWithString:self.imageArray[right]] placeholderImage:self.placeHolder];
    }
    
    self.wheelPageControl.currentPage = self.currentImageIndex;
    [self.wheelScrollView setContentOffset:CGPointMake(self.wheelScrollView.frame.size.width, 0) animated:NO];
}

- (void)setupTimer{
    if (self.interval == 0) {
        self.interval = 3;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(updateWheel) userInfo:nil repeats:YES];
    //避免tableView滚动时，定时器停止
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateWheel{
    CGPoint offset = self.wheelScrollView.contentOffset;
    offset.x += self.wheelScrollView.frame.size.width;
    [self.wheelScrollView setContentOffset:offset animated:YES];
}

- (void)destroy{
    [self.timer invalidate];
}


#pragma mark - Public

+ (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array hasTimer:(BOOL)hastimer interval:(NSUInteger)inter{
    LXBannerView *carousel = [[LXBannerView alloc] initWithFrame:frame];
    carousel.hasTimer = hastimer;
    carousel.interval = inter;
    
    [carousel setupWithArray:array];
    return carousel;
}

+ (instancetype)initWithFrame:(CGRect)frame hasTimer:(BOOL)hastimer interval:(NSUInteger)inter placeHolder:(UIImage *)image{
    LXBannerView *carousel = [[LXBannerView alloc] initWithFrame:frame];
    carousel.placeHolder = image;
    carousel.hasTimer = hastimer;
    carousel.interval = inter;
    carousel.mask.image = image;
    
    return carousel;
}


#pragma mark - Event

#pragma mark - ViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateScrollImage];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateScrollImage];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

@end
