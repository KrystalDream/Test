//
//  AppDelegate.m
//  test
//
//  Created by ZGH on 2020/3/18.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "AppDelegate.h"

#import "GSTabbarController.h"
#import "GSADViewController.h"

/*
 设置启动界面：
    launchScreen  的优先级别 > launchImage   记得清楚缓存，再不行，卸载重新运行
    如果通过launchImage 设置启动界面
    默认屏幕可是范围和 launchImage 图片有关系
    注意：使用launchImage ， 必须让美工提供各种尺寸的启动图片
 
    苹果为什么推荐我们是用 launchScreen （从优先级可以看出 xcode6 才有的）
    launchScreen好处 ： 1、自动识别当前真机和模拟器的尺寸
       2、可以展示各种东西 直接拖控件就可以了  launchImage 只能是图片
 
       拖个image控件在 launchScreen 就可以了 ，只要让美工提供可拉伸的图片 即可
           
    launchScreen 底层实现：把launchScreen截屏 生成一张图片 作为启动图片
 */



//每次程序启动的时候进入广告界面
//1.在启动的时候 去加个广告界面(launchScreen\launchImage 是截屏、图片 不能操作 比如有跳过btn操作)
//2.在启动完成的时候 去加个广告界面（广告界面和启动图片长的一样，视频里是一样的“百思不得解”）
/*
 方案一：程序一启动就进入广告界面，窗口的根控制器设置为广告控制器 （推荐）
 方案二：直接在窗口上再加上一个广告界面，等几秒过去了 再去把广告界面移除（比较麻烦，比如说控制器强引用问题）
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
    GSLog(@"-----------%@",NSStringFromCGRect([UIScreen mainScreen].bounds));

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    GSTabbarController *tabBarVC = [[GSTabbarController alloc] init];
   // init底层会调用 -- > initWithNibName   1、首先判断有没有指定的NibName 2、再判断有没有跟类同名的 xib
    GSADViewController *adVC = [[GSADViewController alloc] init];
    self.window.rootViewController = adVC;//tabBarVC;
    
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
