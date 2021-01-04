//
//  GSLoginRegisterViewController.m
//  test
//
//  Created by Krystal on 2021/1/4.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "GSLoginRegisterViewController.h"

@interface GSLoginRegisterViewController ()

@end

@implementation GSLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerClick:(UIButton *)sender {
    sender.selected = !sender.selected;
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
