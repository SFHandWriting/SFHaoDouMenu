//
//  ScrollView.h
//  HomeWork-others-01
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollView : UIView
//分页显示器未选中的颜色
@property (nonatomic,strong) UIColor *pageIndicatorTintColor;

//分页显示器选中的颜色
@property (nonatomic,strong) UIColor * currentPageIndicatorTintColor;

+ (instancetype)scrollView;

//创建广告条
+(instancetype)scrollViewWithFrame:(CGRect)frame andImages:(NSArray *)images;

+ (instancetype)scrollViewWithFrame:(CGRect)frame andImagesUrls:(NSArray *)imageUrls;


@end
