//
//  AppDelegate.m
//  3DTouch(GZ)
//
//  Created by xinshijie on 2017/4/10.
//  Copyright © 2017年 Mr.quan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GZBaseViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *Nav = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc] init] ];
    self.window.rootViewController = Nav ;
    //添加3Dtouch功能
    [self Add3DTouch];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)Add3DTouch{
    //添加3DTouch方法大致分为两种
    //1.静态添加：在info.plist文件中添加ShortcutItems
    //2.动态添加：
    //这是使用自定义的图片,无论图片是什么颜色显示的都是黑白色
    //UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"图片名字.png"];
    
    //分享应用
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"shortcutTypeOne" localizedTitle:[NSString stringWithFormat:@"分享%@",@"“3DTouch(GZ)”"] localizedSubtitle:@"点击分享" icon:icon userInfo:nil];
    //跳转页面
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeContact];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"shortcutTypeTwo" localizedTitle:[NSString stringWithFormat:@"个人页面"] localizedSubtitle:@"跳转到个人页面" icon:icon1 userInfo:nil];
    
     //定位
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"shortcutTypeThree" localizedTitle:[NSString stringWithFormat:@"定位页面"] localizedSubtitle:nil icon:icon2 userInfo:nil];

    [[UIApplication sharedApplication] setShortcutItems:@[item,item1,item2]];
}

#pragma mark- 执行3Dtouch点击事件
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {

    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    GZBaseViewController *GZVC = [[GZBaseViewController alloc] init];

    if ([shortcutItem.type isEqualToString:@"shortcutTypeOne"]) {
        [self IphoneShare];
    } else if ([shortcutItem.type isEqualToString:@"shortcutTypeTwo"]) {
        GZVC.navTitle = @"GZDemo";
        [nav pushViewController:GZVC animated:YES];
    }else if ([shortcutItem.type isEqualToString:@"shortcutTypeThree"]) {
        GZVC.navTitle = @"3DTouchGZDemo";
        [nav pushViewController:GZVC animated:YES];
    }
}

-(void)IphoneShare{
    //要分享的内容，加在一个数组里边，初始化UIActivityViewController
    NSString *text = @"我是轻斟浅醉17，欢迎关注我！";
    UIImage *image = [UIImage imageNamed:@"投票点击"];
    NSURL *url = [NSURL URLWithString:@"http://www.jianshu.com/u/ab83189244d9"];
    NSArray *activityItems = @[url,text,image];
    NSLog(@"~~~~~~~%@",activityItems);
    
    
    UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self.window.rootViewController presentViewController:vc animated:YES completion:^{
    }];

}

@end
