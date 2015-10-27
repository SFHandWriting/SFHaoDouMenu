//
//  HdFirstCell.m
//  haoDouMenu
//
//  Created by qianfeng on 15/10/23.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HdFirstCell.h"
#import "Header.h"
//#import "UIImageView+WebCache.h"
#import "HdFirstModel.h"
#define baseViewTag 1111
#define baseLabTag 2222



@implementation HdFirstCell

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
    CGFloat width = ScreenWidth / 5;
    CGFloat y = 0;
    
    NSArray * arr = @[@"class",@"shine",@"healthy",@"table",@"shake"];
    for (int i = 0; i < 5; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(width * i , y, width, 80)];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, width/2, width/2)];
        UIImage * image = [UIImage imageNamed:arr[i]];
        image = [self originalImage:image];
        imageView.image = image;
        
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake( 0, 60, width, 20);
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = baseLabTag + i;
        
        view.tag = baseViewTag + i;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        [view addSubview:imageView];
        [view addSubview:label];
        [self.contentView addSubview:view];
        
        
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btn.frame = CGRectMake(width * i, y, width, 60);
//        btn.tag = baseBtnTag + i;
//        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UILabel *label = [[UILabel alloc] init];
//        label.frame = CGRectMake(width * i, 60, width, 29);
//        label.backgroundColor = [UIColor whiteColor];
//        label.textColor = [UIColor blackColor];
//        label.font = [UIFont systemFontOfSize:10];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.tag = baseLabTag + i;
//        
//        UIImage *image = [UIImage imageNamed:arr[i]];
//        image = [self originalImage:image];//调用方法保留图片原色
//        [btn setImage:image forState:UIControlStateNormal];
//        
//        [self.contentView addSubview:label];
//        [self.contentView addSubview:btn];
//        
        
        
    }
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    UIView * view = [self.contentView viewWithTag:tap.view.tag];
    //在这里可以进行传值给菜谱Controller，让它推出页面做不同的事
    
}
//处理图片，保留原色
- (UIImage *)originalImage:(UIImage *)image {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return image;
}
-(void)setModel:(HdFirstModel *)model {
    _model = model;
    for (int i = 0; i < 5; i++) {
       
        UILabel * label = (UILabel *)[self.contentView viewWithTag:baseLabTag + i];
        label.text = model.names[i];
        //NSLog(@"label.text---->%@",label.text);
       
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
