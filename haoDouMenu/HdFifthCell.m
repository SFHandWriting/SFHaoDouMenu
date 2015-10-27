//
//  HdFifthCell.m
//  haoDouMenu
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HdFifthCell.h"
#import "HdFifthModel.h"
#import "UIImageView+WebCache.h"
@interface HdFifthCell()

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;



@end


@implementation HdFifthCell

- (void)setModel:(HdFifthModel *)model {
    _model = model;
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:model.Img]];
    self.titleLabel.text = model.Title;
    self.introLabel.text = model.Intro;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
