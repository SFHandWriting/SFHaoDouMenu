//
//  HdFirstCell.h
//  haoDouMenu
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HdFirstModel;
@interface HdFirstCell : UITableViewCell


@property (nonatomic,strong)NSArray * images;
@property (nonatomic,strong)NSArray * titleNames;
@property (nonatomic,strong)HdFirstModel * model;

@end
