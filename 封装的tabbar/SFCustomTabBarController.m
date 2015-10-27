//
//  SFCustomTabBarController.m
//  CustomTabbar-practice-01
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SFCustomTabBarController.h"
#define baseTage 8989
@interface SFCustomTabBarController ()

@end

@implementation SFCustomTabBarController

+ (instancetype)sfCustomTabBar {
    return [[SFCustomTabBarController alloc] init];
}
+ (instancetype)sfCustomTabBarinitWith:(NSArray *)NormalImages andHighImages:(NSArray *)highImages andTabBarFrame:(CGRect)frame andImageTitles:(NSArray *)titles andTitleColorSelected:(UIColor *)SelColor andTitleFont:(CGFloat)fontSize{
    
   SFCustomTabBarController * sfCustomTabBar = [self sfCustomTabBar];
   return [sfCustomTabBar initWith:NormalImages andHighImages:highImages andTabBarFrame:frame andImageTitles:titles andTitleColorSelected:SelColor andTitleFont:fontSize];
}

#pragma mark - 定制TabBar
//真正如何实现的tabbar的自定义是内部的实现并不会展现出来只留给内部调用
- (id)initWith:(NSArray *)NormalImages andHighImages:(NSArray *)highImages andTabBarFrame:(CGRect)frame andImageTitles:(NSArray *)titles andTitleColorSelected:(UIColor *)SelColor andTitleFont:(CGFloat)fontSize{
    //从外界获得了五个参数（根据功能以后还可以加）
    //参数一：tabbar上未被点击时的图片的名字的数组的集合
    //参数二：tabbar上被选中状态时的图片的名字的数组的集合
    //参数三：由于tabbar是自己定制的那么大小就有自己控制（此处传来的是一个想要tabbar的大小）
    //参数四：图片下面的字
    //参数五：字被选中之后的颜色
    
    //隐藏官方tabbar
    self.tabBar.hidden = YES;
    //在这里设置文字镂空时候的颜色
    self.tabBar.tintColor = [UIColor orangeColor];
    
    //自定义的tabbar是由imageView+buttons组成
    //创建一个图片视图
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
     imageView.backgroundColor = [UIColor whiteColor];
    
    // 放button
    float width  = CGRectGetWidth(frame) / NormalImages.count;
    float height = CGRectGetHeight(frame);
    NSLog(@"self.number----->%ld",(long)self.number);
    for (int i = 0; i < NormalImages.count; i++) {
        //为什么i < ?的大小不用self.number而要用NormalImage.count的原因是：
        //self.number 是在这个方法执行结束后才开始传值过来的，所以一开始就用self.number传过来的值为0
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width * i, 0, width, height);
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:SelColor forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        //设置button文字偏移，让开图片
        //四个值是距离当前位置的顶端，左侧，下面，右侧多远
        CGFloat fromLeft = [UIScreen mainScreen].bounds.size.width / NormalImages.count;
        button.titleEdgeInsets = UIEdgeInsetsMake(40, -fromLeft+fontSize*2, 0, 0);
        
        //设置图片
        [button setImage:[UIImage imageNamed:NormalImages[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:highImages[i]] forState:UIControlStateSelected];
        //设置图片偏移，让开文字
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 17, 0, 0);
        
        //设置点击不闪烁
        button.adjustsImageWhenHighlighted = NO;
        
        // 给一个tag值，来区分点击的是哪个button
        button.tag = baseTage + i;
        // 给button注册事件
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];
        
    }
    //设置imageView可以接受事件(用户交互是否打开)
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    return self;
}
- (void)onClick:(UIButton *)button {
    //被点中，进入选中状态
    button.selected = YES;
    //不能接收事件
    button.userInteractionEnabled = NO;
    
    //切换页面 使用继承父类的方法
    self.selectedIndex = button.tag - baseTage;
    
    //在这里启动userDefault，保存正在选中状态下的视图，或视图的索引
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString * name = button.titleLabel.text;
    NSLog(@"跳转到：%@",name);
    //保存信息到字典
    [userDefaults setObject:name forKey:@"Selected"];
    
    //同步到磁盘
    [userDefaults synchronize];
   //
    //点击了一个页面，别的页面button全灭
    for (NSInteger i = 0; i < self.number ; i ++) {
        UIButton * bt = (id)[self.view viewWithTag:baseTage + i];
        if (i == button.tag - baseTage) {
            //break是结束整个循环体，continue是结束单次循环
            continue;
        }
        bt.selected = NO;
        bt.userInteractionEnabled = YES;
    }
}


@end











































