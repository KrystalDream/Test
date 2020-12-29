//
//  GSSubTagViewController.m
//  test
//
//  Created by 邵梦 on 2020/4/7.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSSubTagViewController.h"
#import "GSSubTagCell.h"

@interface GSSubTagViewController ()

@end

@implementation GSSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"推荐标签";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //注意：如果cell 从xib加载，一定要记住绑定标识符
    

    if(cell == nil){
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GSSubTagCell class]) owner:nil options:nil][0];
    }
    GSLog(@"查看是否复用-----------%p",cell);
    return  cell;
    
}

@end
