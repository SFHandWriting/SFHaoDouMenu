//
//  HdRecipeViewController.m
//  haoDouMenu
//
//  Created by qianfeng on 15/10/21.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HdRecipeViewController.h"
//导入存有url的头文件
#import "Header.h"

//导入封装好的scrollview
#import "ScrollView.h"

// 第一个group的数据模型和cell
#import "HdFirstModel.h"
#import "HdFirstCell.h"

// 第二个group的数据模型和cell
#import "HdSecondModel.h"
#import "HdSecondCell.h"

// 第三个group的数据模型和cell
#import "HdThirdModel.h"
#import "HdThirdCell.h"

// 第四个group的数据模型和cell
#import "HdFourthModel.h"
#import "HdFourthCell.h"

// 第五个gruop的数据模型和cell
#import "HdFifthModel.h"
#import "HdFifthCell.h"

// 全是图片的界面
#import "HdPictureViewController.h"

// 全是评论的界面



@interface HdRecipeViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong)UITableView * tableView;

// 请求循环滚动的数据源数据
@property (nonatomic,strong)NSMutableArray * scroDataSource;

// 请求第一个group的数据源数据
@property (nonatomic,strong)NSMutableArray * firstDataSource;
// 请求第二个group的数据源数据
@property (nonatomic,strong)NSMutableArray * secondDataSource;
// 请求第三个group的数据源数据
@property (nonatomic,strong)NSMutableArray * thirdDataSource;
// 请求第四个group的数据源数据
@property (nonatomic,strong)NSMutableArray * fourthDataSource;
// 请求第五个group的数据源数据
@property (nonatomic,strong)NSMutableArray * fifthDataSource;
@property (nonatomic,strong)NSString       * fifthCount;
@property (nonatomic,strong)NSString       * fifthName;

// 关于navigationBar
@property (nonatomic,strong)UIView * statusView;

// 关于tabbar
@property (nonatomic,assign)CGFloat length;

// 搜索栏
@property (nonatomic,strong)UISearchBar * searchBar;

@end

@implementation HdRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downloadData];
    
    [self createNavigationBar];
}
#pragma mark #####通过tableView滑动的长度来改变alpha，从而设置导航栏的透明度#######
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.length = scrollView.contentOffset.y;
    CGFloat alpha = self.length / widthEx(150);
    NSLog(@"self.length--->%f",self.length);
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
    
//    self.statusView = [[UIView alloc] initWithFrame:CGRectMake(0, - 20, ScreenWidth, 20)];
//    
//    self.statusView.backgroundColor = [UIColor colorWithRed:0.5 green:1 blue:1 alpha:self.length / 700];
//    
//    
//    [self.navigationController.navigationBar addSubview:self.statusView];
//
//    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(removeStatus) userInfo:nil repeats:NO];
    
   
}
- (void)removeStatus  {
    
    for (UIView * view in [self.navigationController.navigationBar subviews]) {
       
        if ([self.navigationController.navigationBar subviews].count >20) {
            [view removeFromSuperview];
        
        }
       
    }
   
    
    
    NSLog(@"删除了");
}
// 创建NavigationBar
- (void)createNavigationBar {
   
    // 是否要隐藏navigationBar
    //self.navigationController.navigationBarHidden = YES;
    
    // 设置navigationBar为透明色
    self.navigationController.navigationBar.translucent = YES;
    
    // 添加一个透明的图片
    UIImage *image = [UIImage imageNamed:@"5d6034a85edf8db16d95b1ee0923dd54574e7485.png"];
   
    // 要想系统的导航栏的颜色为全透明，那么就得放一个透明的图片上去
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    // 写下面这一句的原因是如果没有透明的navigation下会有黑线
    self.navigationController.navigationBar.shadowImage =image;
    
    
    // 这句很重要，这句实现了滚动视图真正的（0，0）点是在屏幕的最左上方，不然就自适应它上面bar的最底端为（0，0）点
    self.automaticallyAdjustsScrollViewInsets = NO;
    
   
   
   
    
}


//下载数据
- (void)downloadData {
      // 初始化数据的地方
    self.scroDataSource   = [[NSMutableArray alloc] init];
    self.firstDataSource  = [[NSMutableArray alloc] init];
    self.secondDataSource = [[NSMutableArray alloc] init];
    self.thirdDataSource  = [[NSMutableArray alloc] init];
    self.fourthDataSource = [[NSMutableArray alloc] init];
    self.fifthDataSource  = [[NSMutableArray alloc] init];
    
      // 网络数据请求
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary * dict = @{@"cacheKey":@"Recipe.getCollectList_0_20",@"limit":@"20",@"offset":@"0",@"sign":@"",@"uid":@"",@"uuid":@"07f70d9642f17dd95982d94b193975a2"};
    
    [manager POST:RecipeURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * result = dict[@"result"];
        

        // 解析第一组的内容
        NSDictionary * tools = result[@"tools"];
        
        NSArray * list2 = tools[@"list"];
        NSMutableArray * imgsUrl = [[NSMutableArray alloc] init];
        NSMutableArray * titles  = [[NSMutableArray alloc] init];
        for (NSDictionary * dict in list2) {
            NSString * img   = dict[@"Img"];
            [imgsUrl addObject:img];
            
            NSString * title = dict[@"Title"];
            [titles addObject:title];
        }
        HdFirstModel * model = [[HdFirstModel alloc] init];
        model.imageURL = imgsUrl;
        model.names = titles;
        [self.firstDataSource addObject:model];
        // NSLog(@"self.firstDataSource----->%@",self.firstDataSource);
        
        
        // 解析第二组的内容
        NSDictionary * album = result[@"album"];
        
        NSArray * list3 = album[@"list"];
        NSMutableArray * secondImgs    = [[NSMutableArray alloc] init];
        NSMutableArray * secondRecipes = [[NSMutableArray alloc] init];
        NSMutableArray * secondTitles  = [[NSMutableArray alloc] init];
        NSMutableArray * secondUrls    = [[NSMutableArray alloc] init];
        for (NSDictionary * dict in list3) {
            NSString * img    = dict[@"Img"];
            NSString * recipe = dict[@"Recipe"];
            NSString * title  = dict[@"Title"];
            NSString * url    = dict[@"Url"];
            [secondImgs addObject:img];
            [secondRecipes addObject:recipe];
            [secondTitles addObject:title];
            [secondUrls addObject:url];
        }
        NSString * secondName = album[@"name"];
        HdSecondModel * secondModel = [[HdSecondModel alloc] init];
        secondModel.imgs    = secondImgs;
        secondModel.recipes = secondRecipes;
        secondModel.titles  = secondTitles;
        secondModel.urls    = secondUrls;
        secondModel.name    = secondName;
        [self.secondDataSource addObject:secondModel];
        NSLog(@"secondModel---->%@",self.secondDataSource);
        
        
        // 解析第三组的内容
        NSDictionary * person = result[@"person"];
        
        NSArray * perList = person[@"list"];
        NSMutableArray * perImg   = [[NSMutableArray alloc] init];
        NSMutableArray * perTitle = [[NSMutableArray alloc] init];
        NSMutableArray * perUrl   = [[NSMutableArray alloc] init];
        for (NSDictionary * dict in perList) {
            NSString * img   = dict[@"Img"];
            [perImg addObject:img];
            
            NSString * title = dict[@"Title"];
            [perTitle addObject:title];
            
            NSString * url   = dict[@"Url"];
            [perUrl addObject:url];
        }
        HdThirdModel *thirdModel = [[HdThirdModel alloc] init];
        thirdModel.imgs   = perImg;
        thirdModel.titles = perTitle;
        thirdModel.urls   = perUrl;
        thirdModel.name   = person[@"name"];
        [self.thirdDataSource addObject:thirdModel];
        // NSLog(@"self.thirdDataSource----->%@",self.thirdDataSource);
        
        
        // 解析第四组数据（将之前计划的第五组那个单个的广告条并入到第四组中）
        NSDictionary * fourRecommed = result[@"recommed"];
        NSArray * fourList = fourRecommed[@"list"];
        NSMutableArray * fourImgs  = [[NSMutableArray alloc] init];
        NSMutableArray * fourIntros = [[NSMutableArray alloc] init];
        NSMutableArray * fourTitles = [[NSMutableArray alloc] init];
        NSMutableArray * fourUrls   = [[NSMutableArray alloc] init];
        for ( NSDictionary * dict in fourList) {
            NSString * fourimg   = dict[@"Img"];
            [fourImgs addObject:fourimg];
            
            NSString * fourintro = dict[@"Intro"];
            [fourIntros addObject:fourintro];
            
            NSString * fourtitle = dict[@"Title"];
            [fourTitles addObject:fourtitle];
            
            NSString * foururl   = dict[@"Url"];
            [fourUrls addObject:foururl];
        }
        //NSLog(@"self.titles------>%@",fourTitles);
        //解析原本预备的第五组的数据并入第四组中
        NSDictionary * ad = result[@"ad"];
        NSString * adImg = ad[@"Img"];
        NSString * adUrl = ad[@"Url"];
        
        HdFourthModel * fourModle = [[HdFourthModel alloc] init];
        fourModle.imgs   = fourImgs;
        fourModle.intros = fourIntros;
        fourModle.titles = fourTitles;
        fourModle.urls   = fourUrls;
        fourModle.adImg  = adImg;
        fourModle.adUrl  = adUrl;
        [self.fourthDataSource addObject:fourModle];
        //NSLog(@"self.fourthDataSource----->%@",self.fourthDataSource);
        
        
        // 解析第五组数据（这里的cell的个数是会变化的）
        NSDictionary * read = result[@"read"];
        NSArray * fifthList = read[@"list"];
        for (NSDictionary * dict in fifthList) {
            HdFifthModel * model = [[HdFifthModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.fifthDataSource addObject:model];
            //NSLog(@"self.fifthDataSource.count--->%lu",(unsigned long)self.fifthDataSource.count);
        }
        //由于cell的的多少不是固定的所以要在这里获得有多少个cell
         self.fifthCount = read[@"Count"];
        //由于组的名字要写在Header里，所以在这里获取组的名字
         self.fifthName = read[@"name"];
        
        //NSLog(@"self.fifthDataSource--->%@",self.fifthDataSource);
        
        
        [self createTableView];// 由于是异步处理，所以是边搭建界面，变下载数据（数据不知是什么时候传过来的），所以要先请求完再搭建界面这样就能防止数据为空，但是又要在scrollview数据请求玩之前搭好界面
        
        
        // 解析scrollview上的数据
        NSDictionary * recipe = result[@"recipe"];
        NSArray * list = recipe[@"list"];
        NSMutableArray * imgs = [[NSMutableArray alloc] init];
        for (NSDictionary * dict in list) {
            NSString * img = dict[@"Img"];
            [imgs addObject:img];
        }
        ScrollView * scrollView = [ScrollView scrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 3) andImagesUrls:imgs];
        self.tableView.tableHeaderView = scrollView;
        //NSLog(@"list---->%@",list);
        
        
       
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error------->%@",error);
    }];
}
#pragma mark 创建tabbleView的地方
- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    //注册第一个group的cell
    [self.tableView registerClass:([HdFirstCell class]) forCellReuseIdentifier:@"firstCell"];
    //注册第二个group的cell
    [self.tableView registerClass:[HdSecondCell class] forCellReuseIdentifier:@"secondCell"];
    //注册第三个group的cell
    [self.tableView registerClass:[HdThirdCell class] forCellReuseIdentifier:@"thirdCell"];
    //注册第四个group的cell
    [self.tableView registerClass:[HdFourthCell class] forCellReuseIdentifier:@"fourthCell"];
    //注册第五个group的cell（这个是带有xib的cell）
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HdFifthCell class]) bundle:nil] forCellReuseIdentifier:@"fifthCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HdSecondCell class]) bundle:nil]forCellReuseIdentifier:@"secondCell"];
    
}


#pragma mark dataSource的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //返回有多少组
    return 6;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return self.fifthCount.intValue;
    }
    //返回有多少行
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
    
        //复用已注册了的cell
        HdFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        HdFirstModel * Model = self.firstDataSource[indexPath.row];
        cell.model = Model;
       // NSLog(@"self.dataSource ----->%@",self.firstDataSource);
        return cell;
        
    }else if (indexPath.section == 1) {
        
        HdSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        HdSecondModel * model = self.secondDataSource[0];
        cell.model = model;
        //NSLog(@"model------>%@",model);
        cell.secondTapBlock = ^(NSInteger tapNum){
            [self pushView:tapNum];
            
        };
        return cell;
    }else if (indexPath.section == 2) {
        HdThirdCell * cell   = [tableView dequeueReusableCellWithIdentifier:@"thirdCell"];
        HdThirdModel * model = self.thirdDataSource[0];
        cell.model = model;
        //NSLog(@"model---->%@",model);
        return cell;
    }else if (indexPath.section == 3) {
        HdFourthCell * cell = [tableView dequeueReusableCellWithIdentifier:@"fourthCell"];
        HdFourthModel * model = self.fourthDataSource[0];
        cell.model = model;
        return cell;
    }else if (indexPath.section == 4) {
        HdFifthCell * cell = [tableView dequeueReusableCellWithIdentifier:@"fifthCell"];
        HdFifthModel * model = self.fifthDataSource[indexPath.row];
        cell.model = model;
        //NSLog(@"self.dataSource----->%@",self.fifthDataSource);
        //设置分割线的样式（none为没有线）
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    
    
    
    static NSString * userId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:userId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userId];
       
    }
    
    return cell;
}
//每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return heightEx(80);
    }else if (indexPath.section == 1) {
        return heightEx(110);
    }else if (indexPath.section == 2) {
        return heightEx(110);
    }else if (indexPath.section == 3) {
        return heightEx(130);
    }else if (indexPath.section == 4) {
        return heightEx(89);
    }
    
    
    return 40;
}
//每个组的头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 4) {
        return heightEx(40);
        
    }
    return 0;
}
//每个组的尾高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark 由于第五个group的特殊性，所以要自定义sectionHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, heightEx(20))];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth, heightEx(20))];
        label.textColor = [UIColor colorWithRed:28 green:-11 blue:123 alpha:1];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.text = self.fifthName;
        //NSLog(@"lable.text----->%@",label.text);
        [view addSubview:label];
        
        return view;
    }else {
        return nil;
    }
    
}


#pragma mark ----推送页面的地方
- (void)pushView:(NSInteger)tapNum {
    //NSLog(@"View传过来了---->%ld",tapNum);
    HdPictureViewController * picture = [[HdPictureViewController alloc] init];
    switch (tapNum) {
        case 0:
        {
         picture.getUrl = @"http://api.haodou.com/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=42bfd7c262b4842962f7a0788ad34532&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C42257134-647B-4012-A2E5-3648A563BE01%7C70A41A14-21F1-4F5F-B67C-E5B949F0F6D1&format=json&loguid=&method=Info.getAlbumInfo&nonce=1445939783&sessionid=1445937983&signmethod=md5&timestamp=1445939783&uuid=07f70d9642f17dd95982d94b193975a2&v=2&vc=42&vn=v5.3.0";
            //aid=7331132&limit=10&offset=0&sign=&uid=&uuid=07f70d9642f17dd95982d94b193975a2
            NSDictionary * dict = @{@"aid":@"7331132",
                                    @"limit":@"10",
                                    @"offset":@"0",
                                    @"sign":@"",
                                    @"uid":@"",
                                @"uuid":@"07f70d9642f17dd95982d94b193975a2"
                                    };
            [self.navigationController pushViewController:picture animated:YES];
            
         break;
        }
            
         case 1:
        {
            
        picture.getUrl = @"http://api.haodou.com/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=1e3d6ad16dd3ed02e16293bfb9c2396e&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C42257134-647B-4012-A2E5-3648A563BE01%7C70A41A14-21F1-4F5F-B67C-E5B949F0F6D1&format=json&loguid=&method=Info.getAlbumInfo&nonce=1445941461&sessionid=1445937983&signmethod=md5&timestamp=1445941461&uuid=07f70d9642f17dd95982d94b193975a2&v=2&vc=42&vn=v5.3.0";
            //aid=6654527&limit=10&offset=0&sign=&uid=&uuid=07f70d9642f17dd95982d94b193975a2
            picture.dict = @{@"aid":@"6654527",
                             @"limit":@"10",
                             @"offset":@"0",
                             @"sign":@"",
                             @"uid":@"",
                             @"uuid":@"07f70d9642f17dd95982d94b193975a2"};
            [self.navigationController pushViewController:picture animated:YES];
            
            break;
        }
        
        case 2:
        {
            
            picture.getUrl = @"http://api.haodou.com/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=bd13d30365dfe1ecdde4616e014a5a8c&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7C42257134-647B-4012-A2E5-3648A563BE01%7C70A41A14-21F1-4F5F-B67C-E5B949F0F6D1&format=json&loguid=&method=Info.getAlbumInfo&nonce=1445941463&sessionid=1445937983&signmethod=md5&timestamp=1445941463&uuid=07f70d9642f17dd95982d94b193975a2&v=2&vc=42&vn=v5.3.0";
            //aid=7051845&limit=10&offset=0&sign=&uid=&uuid=07f70d9642f17dd95982d94b193975a2
            picture.dict = @{@"aid":@"7051845",
                             @"limit":@"10",
                             @"offset":@"0",
                             @"sign":@"",
                             @"uid":@"",
                             @"uuid":@"07f70d9642f17dd95982d94b193975a2"};
            [self.navigationController pushViewController:picture animated:YES];
            
            break;
        }
            
        default:
            break;
    }
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
