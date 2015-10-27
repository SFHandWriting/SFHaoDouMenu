//
//  HdPictureViewController.m
//  haoDouMenu
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HdPictureViewController.h"

@interface HdPictureViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView    * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;

@end

@implementation HdPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downLoad];
    [self createTableView];
    
    self.title = @"菜谱";
    
}
- (void)downLoad {
    //初始化数据
    self.dataSource = [[NSMutableArray alloc] init];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager POST:self.getUrl parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject---->%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error----->%@",error);
    }];
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * userId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:userId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userId];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
