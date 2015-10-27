//
//  ScrollView.m
//  HomeWork-others-01
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ScrollView.h"
#import "UIImageView+WebCache.h"
@interface ScrollView()<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray * images;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,strong) NSTimer * timer;

@end

@implementation ScrollView

+ (instancetype)scrollView {
    
    return [[ScrollView alloc] init];
}

+ (instancetype)scrollViewWithFrame:(CGRect)frame andImages:(NSArray *)images {
    
    ScrollView * scrollView = [self scrollView];
    return [scrollView initWithFrame:frame andImages:images];
}

+ (instancetype)scrollViewWithFrame:(CGRect)frame andImagesUrls:(NSArray *)imageUrls {
    ScrollView * scrollView = [self scrollView];
    return [scrollView initWithFrame:frame andImageUrls:imageUrls];
}

- (instancetype)initWithFrame:(CGRect)frame andImages:(NSArray *)images {
    if (self = [super init]) {
        self.frame = frame;
        self.images = images;
        self.backgroundColor = [UIColor blueColor];
        [self initView];
        [self initPageControl];
        [self initTimer];
    }
    return self;
}
//url
- (instancetype)initWithFrame:(CGRect)frame andImageUrls:(NSArray *)imageUrls {
    if (self = [super init]) {
        self.frame = frame;
        self.images = imageUrls;
        self.backgroundColor = [UIColor blueColor];
        [self initViewWithUrl];
        [self initPageControl];
        [self initTimer];
    }
    return self;
}
- (void)initView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    for (int i = 0; i < self.images.count + 2; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        if (i == self.images.count + 1) {
            imageView.image = [UIImage imageNamed:self.images[0]];
        }
        else if (i == 0){
            imageView.image = [UIImage imageNamed:[self.images lastObject]];
        }
        else {
            imageView.image = [UIImage imageNamed:self.images[i - 1]];
        }
        //建立父子关系
        [self.scrollView addSubview:imageView];
        //设置scrollview的容量
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame), height);
    }
    //设置初始偏移量
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame), 0) animated:YES];
    //打开分页效果
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
#warning 下面这两句是什么意思？
    self.scrollView.shouldGroupAccessibilityChildren = NO;
    self.scrollView.bounces = NO;
}

//关于是URL的
- (void)initViewWithUrl {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    for (int i = 0; i < self.images.count + 2; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        if (i == self.images.count + 1) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.images[0]] ];
        }
        else if (i == 0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[self.images lastObject]]];
        }else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.images[i - 1]]];
        }
        //建立父子关系
        [self.scrollView addSubview:imageView];
        //设置scrollview的容量
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame), height);
    }
    // 设置初始偏移量
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame), 0) animated:YES];
    // 打开分页效果
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.shouldGroupAccessibilityChildren = NO;
    self.scrollView.bounces = NO;
}

- (void)initPageControl {
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
    [self addSubview:self.pageControl];
    self.pageControl.backgroundColor = [UIColor clearColor];
    
    self.pageControl.numberOfPages = self.images.count;
    
    self.pageControl.currentPage = 0;
}

- (void)initTimer {
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [timer fire];
    
}
- (void)timerAction:(NSTimer *)timer {
    NSInteger page = self.scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame);
    [self.scrollView setContentOffset:CGPointMake(++page * CGRectGetWidth(self.scrollView.frame), 0) animated:YES];
   
}

#pragma mark 协议方法
//减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self aboutPageWithScrollView:scrollView];
    
}

//滑动结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView  {
    [self aboutPageWithScrollView:scrollView];
}

- (void)aboutPageWithScrollView:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
  
    self.pageControl.currentPage = page - 1;
    if (page == self.images.count + 1) {
        [self.scrollView setContentOffset:CGPointMake(CGRectGetMaxX(scrollView.frame), 0)];
        self.pageControl.currentPage = 0;
    }
    if (page == 0) {
        [self.scrollView setContentOffset:CGPointMake(self.images.count * CGRectGetMaxX(scrollView.frame), 0)];
        self.pageControl.currentPage = self.images.count;
    }
    
}
//分页显示器的颜色
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
#warning mark写scrollview所遇到的问题
//三个问题：1.NStimer没起到作用 2.最两侧的图片显示了，而中间三张没有显示 3.分页显示器只显示二三页的变动却不显示第一个点
//问题2解决：原因是设置图片的时候写错了
//问题1解决方法：1.用nslog发现只执行一遍2.发现是方法写错了，应该是scheduledTimerWithTimeInterval而自己写成了timerWithTimeInterval
//问题3解决：self.pageControl.currentPage = page - 1;写在了最后面

@end

































