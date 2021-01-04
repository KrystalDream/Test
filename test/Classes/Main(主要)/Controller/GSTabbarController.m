//
//  GSTabbarController.m
//  test
//
//  Created by 邵梦 on 2020/3/19.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSTabbarController.h"
#import "HomeViewController.h"
#import "NewViewController.h"
#import "PublishViewController.h"
#import "FriendTrendViewController.h"
#import "MeViewController.h"
#import "UIImage+Image.h"
#import "GSTabBar.h"
#import "GSNavigationViewController.h"
@interface GSTabbarController ()

@end

@implementation GSTabbarController
//只会调用一次
+ (void)load{
    /*
     appearance
     1、只要遵守了UIAppearance 协议，还要实现这个方法
     2、哪些属性可以用：被UI_APPEARANCE_SELECTOR 宏修饰的属性，才能设置
     appearance  只能在控件显示之前 才有作用
     解决方法：
     [self.view removeFromSuperview]
     [[UIApplication shareApplication].keyWindow addSubView: self.view];
     
     */
    
    
    //获取 整个应用程序下的 UITabBarItem
    
    //UITabBarItem *item = [UITabBarItem appearance];
    // 获取哪个类中的 UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    //富文本 ：描述一个文字的颜色、字体、阴影、空心、图文混排
    //创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor purpleColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    //设置字体 只有正常状态下 才会有效果
    NSMutableDictionary *norDic = [NSMutableDictionary dictionary];
    norDic[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:norDic forState:UIControlStateNormal];

    
}
/*
 选中按钮的标题颜色：对应子控制器的tabbarItem
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2.1 添加子控制器 (5个)
    [self setupAllChildViewController];
  
    //2.2 设置按钮上对应的内容
    [self setupAllBtn];
    
    //2.3 自定义tabBar 替换系统tabBar
    [self setupTabBar];
    
    //tabbarBtn 在 viewWillAppear 的时候添加到self.tabBar

}
- (void) setupAllChildViewController{
    
    HomeViewController *essenceVC = [HomeViewController new];
    
    
      //  不添加导航控制器的时候
      //  [tabBarVC addChildViewController:essenceVC];
      GSNavigationViewController *nav = [[GSNavigationViewController alloc] initWithRootViewController:essenceVC];
      [self addChildViewController:nav];
      
      NewViewController *newVC = [NewViewController new];
      GSNavigationViewController *nav1 = [[GSNavigationViewController alloc] initWithRootViewController:newVC];
      [self addChildViewController:nav1];
      
      //发布特殊 没有导航控制器
//      PublishViewController *publishVC = [PublishViewController new];
//      [self addChildViewController:publishVC];
      
      FriendTrendViewController *friendTrendVC = [FriendTrendViewController new];
      GSNavigationViewController *nav3 = [[GSNavigationViewController alloc] initWithRootViewController:friendTrendVC];
      [self addChildViewController:nav3];
      
      MeViewController *meVC = [MeViewController new];
      GSNavigationViewController *nav4 = [[GSNavigationViewController alloc] initWithRootViewController:meVC];
      [self addChildViewController:nav4];
    
}
- (void) setupAllBtn{
    
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"首页";

    nav.tabBarItem.image = [UIImage imageNamed:@"icon_ibar_ndex_noclick"];

    nav.tabBarItem.selectedImage = [UIImage
                                         imageOriginalNameStr:@"icon_ibar_ndex_click"];
    
    #pragma mark 这么做太麻烦  下列 nav1 nav2 nav3 都要设置富文本  因此在load 方法中用appearance

//    //富文本 ：描述一个文字的颜色、字体、阴影、空心、图文混排
//    //创建一个描述文本属性的字典
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    [nav.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateSelected];

    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新贴";
    nav1.tabBarItem.image = [UIImage  imageNamed:@"icon_ibar_ndex_noclick"];
    nav1.tabBarItem.badgeValue = @"7";
    //快速生成一个没有渲染的图片
    nav1.tabBarItem.selectedImage = [UIImage
                                         imageOriginalNameStr:@"icon_ibar_ndex_click"];
    
    //发布
//    PublishViewController *publishVC = self.childViewControllers[2];
//    publishVC.tabBarItem.image = [UIImage  imageOriginalNameStr:@"icon_ibar_ndex_noclick"];
//    publishVC.tabBarItem.selectedImage = [UIImage
//                                         imageOriginalNameStr:@"icon_ibar_ndex_click"];
    
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage  imageNamed:@"icon_ibar_ndex_noclick"];
    nav3.tabBarItem.selectedImage = [UIImage
                                      imageOriginalNameStr:@"icon_ibar_ndex_click"];
    
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"icon_ibar_ndex_noclick"];
    nav4.tabBarItem.selectedImage = [UIImage
                                      imageOriginalNameStr:@"icon_ibar_ndex_click"];

}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
//    if(tabBarController.selectedIndex == 2){
//
//    }
//    else{

//            [self.tabBar.centerBtn.layer removeAllAnimations];

//        }
    
}
- (void)centerBtnClick{
//    PublishViewController *publishVC = [PublishViewController new];
//    [self presentViewController:publishVC animated:YES completion:nil];
    
}
//如果没有特殊中间button 省略这一步
- (void) setupTabBar{
    
    GSTabBar *tabBar = [[GSTabBar alloc] init];
    
    [tabBar.centerBtn addTarget : self
                         action : @selector(centerBtnClick)
               forControlEvents : UIControlEventTouchUpInside];


    //由于UITabBar是readonly的，所以我们不能直接对他进行赋值，这里利用KVC访问私有变量将GSTabBar赋值给"tabBar"
//    self.tabBar = tabbar;  由于readOnly 所以用KVC 赋值
    
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    tabBar.translucent = NO;


    //x 系列 完全不匹配
    [self setValue:tabBar forKeyPath:@"tabBar"];
    NSLog(@"%@",self.tabBar);
}
@end
