//
//  GSLoginRegisterViewController.m
//  test
//
//  Created by Krystal on 2021/1/4.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "GSLoginRegisterViewController.h"
#import "GSLoginRegisterView.h"

@interface GSLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@end

@implementation GSLoginRegisterViewController
//划分结构 ：顶部 中部 底部
//越复杂的界面 越要封装（复用）
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //封装自定义输入视图  添加到中间的view
    GSLoginRegisterView *loginView = [GSLoginRegisterView loginView];
    [self.middleView addSubview:loginView];
    
    GSLoginRegisterView *registerView = [GSLoginRegisterView registerView];
    registerView.gs_x = self.middleView.gs_size.width *0.5;
    [self.middleView addSubview:registerView];
}
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    //平移中间的view
    _leadCons.constant = -self.middleView.gs_size.width*0.5;
    [UIView animateWithDuration:0.5 animations:^{
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
