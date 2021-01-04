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
    
    //头像变圆角方法：1、 设置头像圆角  2、裁剪图片 （生成新的图片 --- >生成上下文  在cell.m）
    
    //处理cell分割线让其顶到头 :
    //1、自定义分割线，
    //2、系统的属性(ios 8.0)
    //3、万能方式（重写cell的setFrame）了解tableView的底层实现:先把所有cell的大小保存起来，cll 显示的时候 就会拿到cell 去设置   1>取消系统自带分割线   2>把tableView的背景色设置为 分割线的颜色 ，3>重写 setFrame
    
    //tableView 底层实现：先把所有的cell的位置都计算好  保存起来，当cell 要显示的时候 就会拿到这个cell 去设置它的frame  cell.frame = self.frames[row]
               
    [SVProgressHUD showWithStatus:@"加载数据"];
    
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
      
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    //清空tableView 分割线的内边距，清空cell的约束边缘
//    self.tableView.separatorInset = UIEdgeInsetsZero;
}
//存在请求超时的情况  我们在界面即将消失时调用
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //销毁指示器
    [SVProgressHUD dismiss];
    //取消之前的请求-防止消耗性能
//    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    GSFunc;

    GSSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //注意：如果cell 从xib加载，一定要记住绑定标识符
    

    if(cell == nil){
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([GSSubTagCell class]) owner:nil options:nil][0];
    }
    
    cell.model = nil;
//    GSLog(@"查看是否复用-----------%p",cell);
    return  cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GSFunc;
    return 80;
}
@end
