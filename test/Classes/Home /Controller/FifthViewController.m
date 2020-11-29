//
//  FifthViewController.m
//  test
//
//  Created by 邵梦 on 2020/5/9.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()

@end

@implementation FifthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 49 + 64, 0);

    GSLog(@"5个vc 初始化");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idoij5" forIndexPath:indexPath];
    
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",self.class,indexPath.row];
    return cell;
}

@end
