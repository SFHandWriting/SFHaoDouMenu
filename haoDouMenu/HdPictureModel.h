//
//  HdPictureModel.h
//  haoDouMenu
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HdPictureModel : NSObject
// 图片的网址
@property (nonatomic,copy)NSString * imgUrl;
// 图片下面的说明文字
@property (nonatomic,copy)NSString * introduce;

// 图片上的字
@property (nonatomic,copy)NSString * imageBigTitle;
@property (nonatomic,copy)NSString * imageLittleTitle;



@end
