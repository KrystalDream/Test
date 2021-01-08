//
//  GSDetailViewController.m
//  test
//
//  Created by Krystal on 2021/1/8.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "GSDetailViewController.h"
#import "GSSettingViewController.h"
#import "GSWebViewController.h"
@interface GSDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *topImageView;

@end

@implementation GSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    //不要自动设置偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"高志雄";
    
    self.navigationItem.titleView = title;
     
    [self setupNav];
    [self setUp];
}
- (void)setUp{
    
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.bounds;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //当调用 contentInset 会自动调用 scrollViewDidScroll方法
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    self.topImageView = [UIImageView new];
    self.topImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    self.topImageView.clipsToBounds = YES;

    self.topImageView.image = [UIImage imageNamed:@"IMG_1213(20191213-090336)"];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.topImageView];

    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y - (- 200);
    CGFloat height = 200 - offsetY;
    
    NSLog(@"----1----%f------offsetY  %f",height,offsetY);

    if(height < 64){
        height = 64;
    }
    NSLog(@"----2----%f",height);

//    NSLog(@"--------%f",offsetY);

//    self.topImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, height);
    self.topImageView.gs_height = height;
    
NSLog(@"-imgCGRect-------%@",NSStringFromCGRect(self.topImageView.frame));
    
    //根据透明度来生成图片 找最大值
    CGFloat alpha = offsetY*1/135;
    if(alpha >= 1){
        alpha = 0.99;
    }
    
    //把颜色生成图片
    UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    UIImage *iamge = [UIImage imageWithColor:alphaColor];
    [self.navigationController.navigationBar setBackgroundImage:iamge forBarMetrics:UIBarMetricsDefault];
    
    
    UILabel *title = (UILabel *)self.navigationItem.titleView;
    title.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    
}
- (void)setupNav{
    
    

    UIBarButtonItem * UIBarButtonItem1 = [UIBarButtonItem itemWithImage : [UIImage imageNamed:@"icon_bar_ss_noclick"]
                                                         selectedImage : [UIImage
                                                        imageNamed : @"icon_bar_ss_click"]
                                                         addTarget : self
                                                            action : @selector(nightBtn:)];
    
    UIBarButtonItem * UIBarButtonItem2 = [UIBarButtonItem itemWithImage : [UIImage imageNamed:@"icon_bar_ss_noclick"]
                                                            highImage : [UIImage
                                                           imageNamed : @"icon_bar_ss_click"]
                                                            addTarget : self
                                                               action : @selector(settingBtnClick)];
    self.navigationItem.rightBarButtonItems = @[UIBarButtonItem1,UIBarButtonItem2];
    
//    self.navigationController.title = @"2020 暴风成长";
    self.navigationItem.title =  @"我的";
#pragma mark  封装导航栏 整体设置
    //只要是通过模型设置  都是通过富文本设置
//    self.navigationItem setTitle
//    //标题 大小
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
//    [self.navigationController.navigationBar setTitleTextAttributes:dic];

}
- (void)nightBtn:(UIButton *)btn{
    btn.selected = !btn.selected;
}
- (void)settingBtnClick{
    GSSettingViewController *settingVC = [[GSSettingViewController alloc] init];
//    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
    
    //1.底部条 没有隐藏
    //2.处理返回按钮的样式--->去设置界面
    
    
    //跳转WKWeb 页面
//    GSWebViewController *vc = [GSWebViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qq"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qq"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"bill: %ld",(long)indexPath.row];
    return cell;
}
@end
