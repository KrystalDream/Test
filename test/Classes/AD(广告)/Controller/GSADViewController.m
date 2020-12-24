//
//  GSADViewController.m
//  test
//
//  Created by Krystal on 2020/12/23.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSADViewController.h"

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
    
    //加载广告数据
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
