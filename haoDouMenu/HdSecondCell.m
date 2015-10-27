//
//  HdSecondCell.m
//  haoDouMenu
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HdSecondCell.h"
#import "Header.h"
#import "HdSecondModel.h"
#import "UIImageView+WebCache.h"

#define baseLabelTag 1111
#define baseViewTag  2222
#define baseImageViewTag 3333

@interface HdSecondCell()
@property (nonatomic,strong)UILabel * label;

@end


@implementation HdSecondCell

+ (instancetype)listCell {
    return [[self alloc] init];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initView];
    }
    return self;
    
}
- (void)initView {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth, 20)];
    self.label.font = [UIFont boldSystemFontOfSize:17];
    self.label.textColor = [UIColor colorWithRed:28 green:-11 blue:123 alpha:1];
    self.label.backgroundColor = [UIColor clearColor];
    
    
    /**
     下面的定义的值以后可以修改为宏，
     这样方便修改间距以及各自占位的大小
     gap是间隙
     */
    CGFloat gap = widthEx(10);
    CGFloat width = (ScreenWidth - gap * 4 ) / 3 ;
    for (int i = 0; i < 3; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10 + (width + gap) * i, 40, width, 70)];
        view.tag = baseViewTag + i;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        
        //View上的imageView
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        imageView.tag = baseImageViewTag + i;
        imageView.backgroundColor = [UIColor clearColor];
        
        //View上的label
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5 + 50, width, 15)];
        label.font = [UIFont systemFontOfSize:10];
        label.tag = baseLabelTag + i;
        label.backgroundColor = [UIColor clearColor];
        
        [view addSubview:imageView];
        [view addSubview:label];
        [self.contentView addSubview:view];
    }
    
    [self.contentView addSubview:self.label];
    
}

-(void)setModel:(HdSecondModel *)model {
    
    _model = model;
    self.label.text = model.name;
    
    for (int i = 0; i < 3; i++) {
        UIImageView * imageView = (UIImageView *) [self.contentView viewWithTag:baseImageViewTag + i];
        [imageView sd_setImageWithURL:model.imgs[i]];
        
        UILabel * label = (UILabel *)[self.contentView viewWithTag:baseLabelTag + i];
        label.text = model.titles[i];
        //NSLog(@"label.text--->%@",label.text);
    }
    
}
- (UIImage *)originalImage:(UIImage *)image {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return image;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
     //UIView * view = [self.contentView viewWithTag:tap.view.tag];
    if (self.secondTapBlock) {
        self.secondTapBlock(tap.view.tag - baseViewTag);
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
