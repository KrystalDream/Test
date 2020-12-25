//
//  GSADViewController.m
//  test
//
//  Created by Krystal on 2020/12/23.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSADViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface GSADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;

@end

@implementation GSADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置启动图片 这里读取不到 LaunchImage  只能单独重新添加 启动图片在 assets中
    //苹果为什么推出assets  因为之前 很多app 图片都一样  很多应用盗取别人的图片
    [self setUpLaunchImage];
    
    //加载广告数据 -- > AFN
    //cocodpods  管理第三方库：倒入一个框架 会把这个框架所有依赖的所有框架都倒入进去  
    
    //cocodpods 步骤：
    //1、podfile：描述需要导入哪些框架  touch podfile
    //2、打开podfile 描述  open podfile
    //3、搜索需要导入框架的描述  pod search ****
    //4、安装第三方框架 pod install --no-repo-update （不知道怎么拼写的时候  用pod install -help）
    //podfile.lock : 第一次 pod的时候  就会自动生成这个文件，用来描述当前 导入框架的版本号
    //pod install 根据podfile.lock 去加载 ,第一次根据 podfile
    //pod update 去查看知道导入的框架 有没有新的版本，如果有 就更新，并更改 podfile.lock
    //pod repo  管理第三方仓库的索引 去寻找框架有没有最新版本 有就记录
    //5、只能用workspace 打开
    
    [self loadData];

}
- (void)loadData{
   
    /*
      xcode7.0之后 支持https  为了让项目支持http  在info 添加字段 App Transport Security Settings (字典)
      Allow Arbitrary Loads 设置为YES
     https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1585890104255&di=6bf3edf9b9c7130d38f59565964a9b9f&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201903%2F03%2F20190303223637_grjqt.thumb.700_0.jpg
     
     */
    
    //请求   ： 请求头 + 请求体
    //请求头 ： 告诉服务器，客户端支持哪些格式  html json
    //请求体 ： post
    
    //响应   ：响应头 + 响应体
    //响应头 ：content-type 描述服务器给你的数据格式
            //例如：“content-type ：text/html” 报错
            //因为AFN先解析响应头，发现响应头格式不支持，就报错不会继续解析了（这是服务器的错，因为查看后确认数据是json ，是服务器它写错了content-type） 我们不能改服务器，只能改AFN
    //响应体 ：数据
    
    // 1.创建请求会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    //2、发送请求
    [manager GET:@"https://timgsa.baidu.com/timg" parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析数据 写成plist文件
//        [responseObject writeToFile:@"" atomically:YES encoding: error:nil:YES ];
        GSLog(@"%@",responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GSLog(@"%@",error);

    }];
   
}
- (void)setUpLaunchImage{
    
    NSString *imageNameStr;
    if(iPhoneX){
        imageNameStr = @"启动页-1125(1)";


    }else if (iPhoneXs_Max){
        imageNameStr = @"启动页-1242-(1)";

    }else if(isXR){
        imageNameStr = @"启动页-828-(1)";

    }else if(IS_IPHONE_6sp){
        imageNameStr = @"启动页-1242(2)";

    }else if(IS_IPHONE_6s){
        imageNameStr = @"启动页-750";

    }
    else if(IS_IPHONE_5s){
        imageNameStr = @"启动页-640";
    }
    else{
        
        
    }

    self.launchImageView.image = [UIImage imageNamed:imageNameStr];
 
    self.launchImageView.backgroundColor = [UIColor purpleColor];
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
