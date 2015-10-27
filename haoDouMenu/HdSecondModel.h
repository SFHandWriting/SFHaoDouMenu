//
//  HdSecondModel.h
//  haoDouMenu
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HdSecondModel : NSObject

@property (nonatomic,strong)NSArray * imgs;
@property (nonatomic,strong)NSArray * recipes;
@property (nonatomic,strong)NSArray * titles;
@property (nonatomic,copy)NSString  * name;

//跳转到二级页面要用到的网址
@property (nonatomic,strong)NSArray * urls;

@end
