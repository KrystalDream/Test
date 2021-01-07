//
//  GSLoginRegisterViewController.m
//  test
//
//  Created by Krystal on 2021/1/4.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "GSLoginRegisterViewController.h"
#import "GSLoginRegisterView.h"
#import "GSFastLoginView.h"

@interface GSLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation GSLoginRegisterViewController
//划分结构 ：顶部 中部 底部
//越复杂的界面 越要封装（复用）
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*
     屏幕适配
     1、一个view 从xib 加载，需不需要再重新固定尺寸 一定要重新设置一下
     2、在viewDidLoad 设置尺寸frame 好不好，开发一般子在viewDidLayoutSubviews 布局子控件
     */
    
    //封装自定义输入视图  添加到中间的view
    GSLoginRegisterView *loginView = [GSLoginRegisterView loginView];
    [self.middleView addSubview:loginView];

    GSLoginRegisterView *registerView = [GSLoginRegisterView registerView];
    [self.middleView addSubview:registerView];
    
    //添加快速登陆view
    GSFastLoginView *fastView =[GSFastLoginView fastView];
    [self.bottomView addSubview:fastView];
}
//viewDidLayoutSubviews:才会根据布局调整拉伸尺寸
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    GSLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0,self.middleView.gs_width *0.5, self.middleView.gs_height);

    
    GSLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.gs_width *0.5, 0,self.middleView.gs_width *0.5, self.middleView.gs_height);
    
    GSFastLoginView *fastView = self.bottomView.subviews.firstObject;
    
    fastView.frame = self.bottomView.bounds;
}
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    //平移中间的view
    _leadCons.constant = _leadCons.constant == 0 ? -self.middleView.gs_size.width*0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
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
