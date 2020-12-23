//
//  GSNavigationViewController.m
//  test
//
//  Created by 邵梦 on 2020/3/25.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSNavigationViewController.h"

@interface GSNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation GSNavigationViewController
//只会调用一次
+ (void)load{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    //标题 大小
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:dic];
    
    //设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBackImage"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    GSLog(@"------------%@",self.interactivePopGestureRecognizer.delegate);//证明侧滑返回手势代理存在
    //控制手势什么时候触发，只有在非根控制器才需要触发
    self.interactivePopGestureRecognizer.delegate = self;

    //在根控制器  做侧滑  导致
    //假死状态 :程序还在运行，但是界面动不了
    
    
    //做全屏滑动返回
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate  action:@selector(handleNavgationTransition)];
//    [self.view addGestureRecognizer:pan];
//
//    pan.delegate = self;
//
//    //禁止之前的系统手势
//    self.interactivePopGestureRecognizer.enabled = NO;
    
    //标题 大小
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:28];
//    [self.navigationBar setTitleTextAttributes:dic];
    
}
/*
 <_UIParallaxTransitionPanGestureRecognizer: 0x7fc89a816840; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fc89a815530>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fc89a8111a0>)>>
 */
#pragma mark UIGestureRecognizerDelegate
//决定是否触发手势 非根控制器 
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //设置返回按钮 只有非根控制器
    /*
     根控制器 不添加返回按钮：
     在[super pushViewController:viewController animated:animated]这句话之前  meVC 还没有放进nav4中
     */
    if(self.childViewControllers.count > 0){//非根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        //恢复滑动功能：---> 分析：把系统的返回按钮覆盖 -->1.手势失效（1、手势被清空(打印证明 手势存在)、2.可能手势代理做了一些事情、导致手势失败）
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem
                                                           backItemWithImage:[UIImage
                                                                              imageNamed:@"icon_nav_back"]
                                                           highImage:[UIImage
                                                                      imageNamed:@"icon_nav_back"]
                                                           addTarget:self
                                                           action:@selector(back)
                                                           title:@"返回"];
        
//        GSLog(@"------%@",self.interactivePopGestureRecognizer);
    }
    
    //super 必须调用  真正的跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}
@end
