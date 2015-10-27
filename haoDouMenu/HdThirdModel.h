//
//  HdThirdModel.h
//  haoDouMenu
//
//  Created by qianfeng on 15/10/25.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HdThirdModel : NSObject

//三个视频以及视频下面的说明文字
@property (nonatomic,strong)NSArray * imgs;
@property (nonatomic,strong)NSArray * titles;
@property (nonatomic,strong)NSArray * urls;
@property (nonatomic,copy) NSString * name;
@end
