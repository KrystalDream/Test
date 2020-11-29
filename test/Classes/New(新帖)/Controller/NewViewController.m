//
//  NewViewController.m
//  test
//
//  Created by 邵梦 on 2020/3/19.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "NewViewController.h"
#import "GSSubTagViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage : [UIImage imageNamed:@"icon_bar_ss_noclick"]
                                                            highImage : [UIImage
                                                           imageNamed : @"icon_bar_ss_click"]
                                                            addTarget : self
                                                               action : @selector(game)];
}
- (void)game{
    GSSubTagViewController *subTagVC = [GSSubTagViewController new];
    
    [self.navigationController pushViewController:subTagVC animated:YES];
    
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
