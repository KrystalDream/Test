//
//  AllViewController.m
//  test
//
//  Created by 邵梦 on 2020/5/9.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "AllViewController.h"

@interface AllViewController ()
@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 49 + 64, 0);
    GSLog(@"--333-----AllViewController初始化");
//      NSArray *arr = @[@{@"name":@"奥迪",@"price":@"700"},
//      @{@"name":@"奔驰",@"price":@"1000"},
//      @{@"name":@"宝马",@"price":@"100"},
//      @{@"name":@"保时捷",@"price":@"1000"}];
//    BOOL isPlist = [arr writeToFile:@"/Users/shaomeng/Desktop/car.plist" atomically:YES];
    
    
    
    GSFunc;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
    UITableViewCell *cell = [UITableViewCell new];

    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",self.class,indexPath.row];
    return cell;
}



@end
