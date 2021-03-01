//
//  GSSettingViewController.m
//  test
//
//  Created by 邵梦 on 2020/3/25.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSSettingViewController.h"
#import "GSFileTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "STPickerDate.h"
#import "PrivacyViewController.h"

#define CachesPath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface GSSettingViewController ()<STPickerDateDelegate>
@property (nonatomic, assign) NSInteger totalSize;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation GSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
#pragma mark  讲述返回按钮的写法
    
    //返回按钮
//    UIButton *btn = [UIButton new];
//    [btn setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [btn sizeToFit];
//
//    //让按钮贴着左边
//    //正数就是距相应的边的距离增加，负数就是距相应的距离减少
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
////    btn.imageEdgeInsets =
////    btn.titleEdgeInsets =
//    [btn addTarget : self
//            action : @selector(back)
//  forControlEvents : UIControlEventTouchUpInside];
    
#warning 返回箭头 溢出btn  点击不能触发
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"icon_nav_back"]
//                                                                     highImage:[UIImage
// imageNamed:@"icon_nav_back"]
//                                                                     addTarget:self
//                                                                        action:@selector(back) title:@"返回"];
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:0 target:self action:@selector(nextPage)];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸....."];

    [GSFileTool getFileSize:CachesPath completion:^(NSInteger totalSize) {
        
        __weak __typeof(self)weakSelf = self;
        GSLog(@"currentThread :%@",[NSThread currentThread]);
        weakSelf.totalSize = totalSize;
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
      }];
    
}
- (void)nextPage{
    UIViewController *vc = [UIViewController new];
    //这样 太麻烦了  所以 监听UINavigationController 中的push方法
//    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"icon_nav_back"]
//                                                                        highImage:[UIImage
//    imageNamed:@"icon_nav_back"]
//                                                                        addTarget:self
//                                                                           action:@selector(back) title:@"返回"];
       

    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
    
    
  
    
}
//- (void)back{
//    [self.navigationController popViewControllerAnimated:YES];
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    UITableViewCell *cell = [UITableViewCell new];
    // 沙盒相当于整个程序的文件夹
    // 计算缓存数据 :计算整个应用程序的缓存数据 => 沙盒(cache) => 获取cache文件夹的尺寸
    // SDWebImage 是帮我们缓存到 Library -> caches -> defult
    
    switch (indexPath.row) {
        case 0:
        {
            //清除缓存尺寸字符串
             cell.textLabel.text = [self sizeStr];
        }
            break;
        case 1:
            cell.textLabel.text = @"线程";

            break;
        case 2:
            cell.textLabel.text = @"GCD线程间通信 -- 参考缓存数据计算";
            break;
        case 3:
            cell.textLabel.text = @"日期picker";
            break;
        case 4:
            cell.textLabel.text = @"协议点击";
            break;
        case 5:
            cell.textLabel.text = @"storyBoard";
            break;
        default:
            break;
    }
 

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
               //清除缓存
            //删除文件夹里面所有文件
            [GSFileTool removeDirectoryPath:CachesPath];
            _totalSize = 0;
            [self.tableView reloadData];
        }
            break;
        case 1:
        {
            
            [self sycnSerial];
        }
            break;
        case 2:
            break;
        case 3:{
            
            STPickerDate *pickerDate = [[STPickerDate alloc]init];
            pickerDate.tag = 2019;
            [pickerDate setDelegate:self];
            pickerDate.pickerTitle = @"入学时间";
            [pickerDate show];
        }
            break;
            
        case 4:{
            
            PrivacyViewController *vc = [PrivacyViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        case 5:{
            
            PrivacyViewController *vc = [PrivacyViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
    }
}


#pragma mark DatePickerDelegate
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSString *m = ((month<10)? [NSString stringWithFormat:@"0%zd",month] : [NSString stringWithFormat:@"%zd",month]);
    NSString *d = ((day<10)? [NSString stringWithFormat:@"0%zd",day] : [NSString stringWithFormat:@"%zd",day]);
    NSString *text = [NSString stringWithFormat:@"%zd-%@-%@", year, m, d];
    
   
    
}


//异步 + 并发队列：会开启多条线程，队列中的任务是并发执行
- (void)asycnConcurrent{
    //1、创建队列  参数：标签、队列的类型
    dispatch_queue_t queue = dispatch_queue_create("com.tag.download", DISPATCH_QUEUE_CONCURRENT);

    //2、添加任务到队列
    dispatch_async(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    
    
}
//异步 + 串行队列 ：会开线程，开一条线程，队列中的任务是串行执行的 即一个任务执行完再执行下一个任务
- (void)acyncSerial{
    //1、创建队列
    dispatch_queue_t queue = dispatch_queue_create("downLoad", DISPATCH_QUEUE_SERIAL);
    
    //2、添加任务到队列
    dispatch_async(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    
}
//同步 + 并发队列：不会开线程 任务是串行执行的
- (void)sycnConcurrent{
    
    //1、创建队列  参数：标签、队列的类型
    //     dispatch_queue_t queue = dispatch_queue_create("com.tag.download", DISPATCH_QUEUE_CONCURRENT);
    
    // 获取全局并发队列 （GCD自带）  参数：优先级、给未来使用的（我们传0）
    // DISPATCH_QUEUE_PRIORITY_DEFAULT   0
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    //2、添加任务到队列
       dispatch_sync(queue, ^{
           GSLog(@"---------%@",[NSThread currentThread]);
       });
       dispatch_sync(queue, ^{
           GSLog(@"---------%@",[NSThread currentThread]);
       });
       dispatch_sync(queue, ^{
           GSLog(@"---------%@",[NSThread currentThread]);
       });
#warning 开多少个线程 是GCD的事情  我们复制100个  不一定开100个线程
}

//同步 + 串行队列：不会开线程 任务是串行执行的
- (void)sycnSerial{
    
    //1、创建队列  参数：标签、队列的类型
     dispatch_queue_t queue = dispatch_queue_create("com.tag.download", DISPATCH_QUEUE_SERIAL);
    
    //2、添加任务到队列
       dispatch_sync(queue, ^{
           GSLog(@"---------%@",[NSThread currentThread]);
       });
       dispatch_sync(queue, ^{
           GSLog(@"---------%@",[NSThread currentThread]);
       });
       dispatch_sync(queue, ^{
           GSLog(@"---------%@",[NSThread currentThread]);
       });
    
}


//异步+主队列：所有任务都在主线程中执行，不会开启线程
- (void)asyncMain{
    
    //1、获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //2、添加任务到队列
    dispatch_async(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });

}

//同步+主队列（是GCD自带的一种特殊的串行队列）：死锁
//注意：如果该方法放到子线程中执行，那么所有的任务在主线程中执行
- (void)syncMain{
    
    //1、获得主队列
    //放到主队列的任务，都会放到主线程中执行
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    GSLog(@"start---------------");
    //2、添加任务到队列 同步函数的特点是立刻马上执行，如果我没有执行完毕，后面的也别想执行
    dispatch_sync(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        GSLog(@"---------%@",[NSThread currentThread]);
    });
    GSLog(@"end---------------");
}
- (NSString *)sizeStr{
    
  
    //NSInteger totalSize = [GSFileTool getFileSize:cachesPath];
    NSInteger totalSize = _totalSize;
    
    NSString *sizeStr = @"清除缓存";
    if(totalSize > 1000*1000){
        CGFloat sizeF = totalSize/1000.0/1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    }else if (totalSize > 1000){
        CGFloat sizeF = totalSize/1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    }else if (totalSize > 0){
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    return sizeStr;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
