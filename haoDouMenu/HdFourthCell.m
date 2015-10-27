//
//  HdFourthCell.m
//  haoDouMenu
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HdFourthCell.h"
#import "HdFourthModel.h"
#import "Header.h"
#import "UIImageView+WebCache.h"


@interface HdFourthCell()

@property (nonatomic,strong)UIImageView * firstImageView;
@property (nonatomic,strong)UILabel     * firstBigTitle;
@property (nonatomic,strong)UILabel     * firstSmallTitle;

@property (nonatomic,strong)UIImageView * secondImageView;
@property (nonatomic,strong)UILabel     * SecondBigTitle;
@property (nonatomic,strong)UILabel     * SecondSmallTitle;

@property (nonatomic,strong)UIImageView * thirdImageView;

@end

@implementation HdFourthCell

+ (instancetype)fourCell {
    return [[self alloc] init];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initView];
    }
    return self;
}
//0x7fc941675b20
- (void)initView {
    CGFloat width = ScreenWidth;
    // 将第四组的group分为三个View
    UIView * firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width / 2, 60)];
    
    
    UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(width / 2, 0, width / 2, 60)];
   
    
    UIView * thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, width, 70)];
   
    
    // 布置第一个View中的图片以及文字
    self.firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 30)];
    self.firstImageView.layer.cornerRadius = 15;
    self.firstImageView.clipsToBounds = YES;
    self.firstBigTitle  = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, width / 2 - 60, 20)];
    self.firstBigTitle.font      = [UIFont boldSystemFontOfSize:15];
    self.firstBigTitle.textColor = [UIColor blackColor];
    
    self.firstSmallTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, width / 2 - 60, 10)];
    self.firstSmallTitle.font      = [UIFont boldSystemFontOfSize:12];
    self.firstSmallTitle.textColor = [UIColor grayColor];
    
        // 将第一个视图中的东西添加到第一个View中
    [firstView addSubview:self.firstImageView];
    [firstView addSubview:self.firstBigTitle];
    [firstView addSubview:self.firstSmallTitle];
    [self.contentView addSubview:firstView];
    
    
    // 布置第二个视图中的图片以及文字
    self.secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 30)];
    self.secondImageView.layer.cornerRadius = 15;
    self.secondImageView.clipsToBounds = YES;
    
    self.SecondBigTitle  = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, width / 2 - 60, 20)];
    self.SecondBigTitle.font      = [UIFont boldSystemFontOfSize:15];
    self.SecondBigTitle.textColor = [UIColor blackColor];
    
    self.SecondSmallTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, width / 2 - 60, 10)];
    self.SecondSmallTitle.font      = [UIFont boldSystemFontOfSize:12];
    self.SecondSmallTitle.textColor = [UIColor grayColor];
    
       // 将第二个视图中的东西添加到第二个View中
    [secondView addSubview:self.secondImageView];
    [secondView addSubview:self.SecondBigTitle];
    [secondView addSubview:self.SecondSmallTitle];
    [self.contentView addSubview:secondView];
    
    
    // 布置第三个视图
    self.thirdImageView = [[UIImageView alloc] initWithFrame:thirdView.frame];
    [thirdView addSubview:self.thirdImageView];
    [self.contentView addSubview:thirdView];
    
    //之后做跳转的时候，要给每一个View添加手势，通过tag来一次性区分是不行的
    
}

- (void)setModel:(HdFourthModel *)model {
    _model = model;
    //设置第一个View的内容
    [self.firstImageView sd_setImageWithURL:model.imgs[0]];
    self.firstBigTitle.text   = model.titles[0];
    self.firstSmallTitle.text = model.intros[0];
  
    //设置第二个View的内容
    [self.secondImageView sd_setImageWithURL:model.imgs[1]];
    self.SecondBigTitle.text   = model.titles[1];
    self.SecondSmallTitle.text = model.intros[1];
   
    //设置第三个View的内容
    [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:model.adImg]];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
