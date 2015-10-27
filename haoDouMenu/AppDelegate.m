//
//  AppDelegate.m
//  haoDouMenu
//
//  Created by qianfeng on 15/10/21.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"

#import "HdGuideViewController.h"
#import "HdRecipeViewController.h"
#import "HdHomeViewController.h"
#import "HdSquareViewController.h"
#import "HdMySelfViewController.h"
#import "HdRootViewController.h"
//封装的tabbar
#import "SFCustomTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.rootViewController = [[HdGuideViewController alloc] init];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(createTabbar) userInfo:nil repeats:NO];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}
- (void)createTabbar {
    NSArray * arr = @[@"HdRecipeViewController",@"HdHomeViewController",@"HdSquareViewController",@"HdMySelfViewController"];
    NSMutableArray * vcs = [[NSMutableArray alloc] init];
    for (int i = 0; i < arr.count; i++) {
        Class class = NSClassFromString(arr[i]);
        HdRootViewController * root = [[class alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:root];
        [vcs addObject:nav];
    }
    //数组，存放图片普通状态下的名称
    NSArray * image = @[@"食谱A@2x",@"喜欢A@2x",@"食课A@2x",@"我的A@2x"];
    //数组，存放图片高亮状态下的名称
    NSArray * selectedImages = @[@"食谱B@2x",@"喜欢B@2x",@"食课B@2x",@"我的B@2x"];
    //数组，存放title的名字
    NSArray * titleName = @[@"菜谱",@"到家",@"广场",@"我的"];
    //调用自定义tabbar时给它赋上自己想要赋的值
    SFCustomTabBarController * sfTab = [SFCustomTabBarController sfCustomTabBarinitWith:image andHighImages:selectedImages andTabBarFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50) andImageTitles:titleName andTitleColorSelected:[UIColor redColor] andTitleFont:7];
    sfTab.viewControllers = vcs;
    sfTab.number = 4;
    
    self.window.rootViewController = sfTab;
    
   // NSLog(@"跳转过来了");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
