//
//  ThirdViewController.m
//  test
//
//  Created by 邵梦 on 2020/5/9.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 49 + 64, 0);

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id3" forIndexPath:indexPath];
    UITableViewCell *cell = [UITableViewCell new];

    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",self.class,indexPath.row];
    return cell;
}
@end
