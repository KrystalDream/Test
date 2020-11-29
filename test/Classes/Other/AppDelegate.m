//
//  AppDelegate.m
//  test
//
//  Created by ZGH on 2020/3/18.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "AppDelegate.h"

#import "GSTabbarController.h"
//每次程序启动的时候进入广告界面
//1.在启动的时候 去加个广告界面
//2.在启动完成的时候 去加个广告界面
/*
 方案一：程序一启动就进入广告界面，窗口的根控制器设置为广告控制器
 方案二：直接在窗口上再加上一个广告界面，等几秒过去了 再去把广告界面移除
 */

@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark 监听点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [touches.anyObject locationInView:nil];
    if(point.y <= 20){
        
        GSLog(@"点击了状态栏");
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    GSTabbarController *tabBarVC = [[GSTabbarController alloc] init];
    self.window.rootViewController = tabBarVC;
    
    //如果想要在某个UIViewController中禁用深色模式
    if (@available(iOS 13.0, *)) {
        [self.window setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
    }

    [self.window makeKeyAndVisible];
   
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
