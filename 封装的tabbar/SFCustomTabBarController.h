//
//  SFCustomTabBarController.h
//  CustomTabbar-practice-01
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFCustomTabBarController : UITabBarController


#pragma mark 除了要传五个参数外，还要给number赋值（是在这个类创建出来后）


//传过来所需要button的个数，也就是点击响应的Controller的个数
@property (nonatomic,assign)NSInteger number;

+ (instancetype)sfCustomTabBar;

//从外界获得了五个参数（根据功能以后还可以加）
//参数一：tabbar上未被点击时的图片的名字的数组的集合
//参数二：tabbar上被选中状态时的图片的名字的数组的集合
//参数三：由于tabbar是自己定制的那么大小就由自己控制（此处传来的是一个想要tabbar的大小）
//参数四：图片下面的字
//参数五：字被选中之后的颜色
+ (instancetype)sfCustomTabBarinitWith:(NSArray *)NormalImages andHighImages:(NSArray *)highImages andTabBarFrame:(CGRect)frame andImageTitles:(NSArray *)titles andTitleColorSelected:(UIColor *)SelColor andTitleFont:(CGFloat)fontSize;

@end
