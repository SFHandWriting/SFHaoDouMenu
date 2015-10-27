//
//  HdSecondCell.h
//  haoDouMenu
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HdSecondModel;
@interface HdSecondCell : UITableViewCell
@property (nonatomic,strong)HdSecondModel * model;

@property (nonatomic,strong)void(^secondTapBlock)(NSInteger tag);
@end
