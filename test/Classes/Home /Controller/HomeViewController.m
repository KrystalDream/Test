//
//  EssenceViewController.m
//  test
//
//  Created by 邵梦 on 2020/3/18.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "HomeViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "EssenceItemModel.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "AllViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "FifthViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) AFHTTPSessionManager *manager; //因为是系统管理 所以用weak
@property (nonatomic,strong) UIScrollView *scrView;

@property (nonatomic,strong) UIView *titleBtnView;
@property (nonatomic,strong) UIView *underLineView;
@property (nonatomic,strong) UIButton *preBtn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self makeChildView];
    [self setupNav];

    //请求数据---> AFN
    /*
    [self loadData];
    //如果网不好 一直请求  一直转 跳转到其他y界面 也是一样存在 (viewDidDisappear 处理)
    [SVProgressHUD showWithStatus:@"加载中"];
    */
    [self makeView];
    
    
    //默认 添加第一个vc
    [self addChildViewIntoScrollerView:0];

    
}
- (void)makeChildView{
    
    [self addChildViewController:[[AllViewController alloc]init]];
    GSLog(@"-------AllViewController添加");

    [self addChildViewController:[[SecondViewController alloc]init]];
    [self addChildViewController:[[ThirdViewController alloc]init]];
    [self addChildViewController:[[ForthViewController alloc]init]];
    [self addChildViewController:[[FifthViewController alloc]init]];
    GSLog(@"-------vc5添加");


}
- (void)makeView{
    //不允许自动修改scr的内边距 这样子vc的tableViewframe就置顶了
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scrView = [UIScrollView new];
    self.scrView.delegate = self;
    self.scrView.frame = self.view.bounds;
    self.scrView.backgroundColor = [UIColor blueColor];
    self.scrView.showsHorizontalScrollIndicator = NO;
    self.scrView.showsVerticalScrollIndicator = NO;
    self.scrView.pagingEnabled = YES;

    [self.view addSubview:self.scrView];
    GSLog(@"scrView :%@",NSStringFromCGRect(self.scrView.frame));

    
    NSInteger count = self.childViewControllers.count;
    CGFloat scrW = self.scrView.gs_width;
//    CGFloat scrH = self.scrView.gs_height;

//    for(NSInteger i = 0; i < count;i++){
//        GSLog(@"-------AllViewController-for循环");
//        UIView *childView = self.childViewControllers[i].view;
//
//        childView.gs_x = i*scrW;
//        childView.gs_y = 0;
//        childView.gs_height = scrH;
//        [self.scrView addSubview:childView];
//
//        GSLog(@"%@",NSStringFromCGRect(childView.frame));
//    }
//
    
    self.scrView.contentSize = CGSizeMake(count*scrW, 0);
    
    
    
    self.titleBtnView = [UIView new];
    self.titleBtnView.gs_width = self.view.bounds.size.width;
    self.titleBtnView.gs_height = 50;
    self.titleBtnView.backgroundColor = [UIColor whiteColor];
//    self.titleBtnView.backgroundColor = [UIColor colorWithRed:123/255.0 green:118/255.0 blue:197/255.0 alpha:0.5];
    [self.view addSubview:self.titleBtnView];
    
    NSArray *titleArr = @[@"page1",@"page2",@"page3",@"page4",@"page5"];
    
    for(NSInteger i = 0 ; i < titleArr.count ; i++){
        
        UIButton *btn = [UIButton new];
        btn.gs_width = GSScreenW/titleArr.count;
        btn.gs_height = 50;
        btn.gs_x = i *  btn.gs_width;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [btn setTitleColor:[UIColor lightGrayColor]
                  forState:UIControlStateNormal];
        
        if(i == 0){
            btn.selected = YES;
            self.preBtn = btn;
        }
        
        [btn addTarget : self
                action : @selector(btnClick:)
      forControlEvents : UIControlEventTouchUpInside];
        [self.titleBtnView addSubview:btn];
    }
    
    UIButton *btn = self.titleBtnView.subviews.firstObject;
    self.underLineView = [UIView new];
    self.underLineView.gs_height = 2;
    self.underLineView.gs_width = 50;
    self.underLineView.gs_centerX = btn.gs_centerX;

    self.underLineView.gs_bottom = self.titleBtnView.gs_height;
    //获取 btn上字体的颜色
    [btn.titleLabel sizeToFit];//让label 根据文字内容计算尺寸
    self.underLineView.gs_width = [btn.currentTitle sizeWithAttributes:@{NSFontAttributeName:btn.titleLabel.font}].width;
    self.underLineView.gs_centerX = btn.gs_centerX;

    self.underLineView.backgroundColor = [btn titleColorForState:UIControlStateSelected];
    [self.titleBtnView addSubview:self.underLineView];
    
    
}
- (void)btnClick:(UIButton *)btn{
    self.preBtn.selected = NO;
    btn.selected = YES;
    self.preBtn = btn;
    NSInteger index = [self.titleBtnView.subviews indexOfObject:btn];
  

    [UIView animateWithDuration:0.25 animations:^{
        self.underLineView.gs_width = [btn.currentTitle sizeWithAttributes:@{NSFontAttributeName:btn.titleLabel.font}].width;
        self.underLineView.gs_centerX = btn.gs_centerX;
        
        
//        NSInteger index = [self.titleBtnView.subviews indexOfObject:btn];
        CGFloat offSetX = self.scrView.gs_width*index;
        self.scrView.contentOffset =  CGPointMake(offSetX, self.scrView.contentOffset.y);
        
                
    } completion:^(BOOL finished) {
        //点哪个按钮  取哪个控制器
        
//        UIView *childView = self.childViewControllers[index].view;
//        childView.gs_x = index*scrW;
//        childView.gs_y = 0;
//        childView.gs_height = scrH;
//        [self.scrView addSubview:childView];
        
        [self  addChildViewIntoScrollerView:index];

    }];
    
    //设置index位置对应的tableView.scrollsToTop = YES 其他设置为NO
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVC = self.childViewControllers[i];
        //如果view还没被创建就不用被处理
        if(!childVC.isViewLoaded) continue;
        
        UIScrollView *scrlollView = (UIScrollView *)childVC.view;
        if(![scrlollView isKindOfClass:[UIScrollView class]]) continue;
        scrlollView.scrollsToTop = (i == index);
        
    }
    
}
- (void)makeTitleBtn{
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //销毁指示器
    [SVProgressHUD dismiss];
    //取消之前的请求
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    
}
- (void)loadData{
   
    /*
      xcode7.0之后 支持https  为了让项目支持http  在info 添加字段 App Transport Security Settings (字典)
      Allow Arbitrary Loads 设置为YES
     https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1585890104255&di=6bf3edf9b9c7130d38f59565964a9b9f&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201903%2F03%2F20190303223637_grjqt.thumb.700_0.jpg
     
     */
    // 1.创建请求会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    _manager = manager;
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    //2、发送请求
    [manager GET:@"https://timgsa.baidu.com/timg" parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析数据 写成plist文件
//        [responseObject writeToFile:@"" atomically:YES encoding: error:nil:YES ];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
   
}
- (void)setupNav{

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage : [UIImage imageNamed:@"icon_bar_ss_noclick"]
                                                         highImage : [UIImage
                                                        imageNamed : @"icon_bar_ss_click"]
                                                         addTarget : self
                                                            action : @selector(game)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage : [UIImage imageNamed:@"icon_bar_ss_noclick"]
                                                            highImage : [UIImage
                                                           imageNamed : @"icon_bar_ss_click"]
                                                            addTarget : self
                                                               action : @selector(game)];
    
//    self.navigationController.title = @"2020 暴风成长";
    self.navigationItem.title =  @"2020 暴风成长";

}

- (void)game{
    GSFunc;
    
    
}
#pragma mark scrollerViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/self.scrView.gs_width;
    UIButton *btn = [self.titleBtnView.subviews objectAtIndex:index];
    [self btnClick:btn];
}

- (void)addChildViewIntoScrollerView:(NSInteger)index{
    
    CGFloat scrW = self.scrView.gs_width;
    CGFloat scrH = self.scrView.gs_height;
    UIView *childView = self.childViewControllers[index].view;
    
    
//    if(childView.superview) return;
    if(childView.window) return;
    
    childView.gs_x = index*scrW;
    childView.gs_y = 0;
    childView.gs_height = scrH;
    [self.scrView addSubview:childView];
}
@end
