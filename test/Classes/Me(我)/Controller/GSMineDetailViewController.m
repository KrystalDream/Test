//
//  GSMineDetailViewController.m
//  test
//
//  Created by Krystal on 2021/2/20.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "GSMineDetailViewController.h"

@interface GSMineDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GSMineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor orangeColor];
    return  cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  3;
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
