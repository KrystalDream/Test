//
//  FriendTrendViewController.m
//  test
//
//  Created by 邵梦 on 2020/3/19.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "FriendTrendViewController.h"
#import "AFNetworking.h"
#import "NetManager.h"
#import "GSLoginRegisterViewController.h"
#import "UITextField+PlaceHolder.h"

@interface FriendTrendViewController ()
@property (nonatomic ,strong) NSString *cookieId;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *testField;

@end

@implementation FriendTrendViewController{
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"我的关注";
    [self loginTest];


    self.iconImageView.layer.cornerRadius = 50;
    self.iconImageView.layer.masksToBounds = YES;
    
    
    //分析：为什么先设置占位文字颜色，就没有效果   ------> 占位文字的label 拿不到 （OC是懒加载机制 ：没设置占位文字，不会创建这个控件）
    self.testField.placeHolderColor = [UIColor greenColor];

    self.testField.placeholder = @"测试封装分类";

    
}
- (IBAction)loginBtnClick:(id)sender {
    
    GSLoginRegisterViewController *vc = [GSLoginRegisterViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self ListTest];

}

- (void)ListTest{
     [self.manager.requestSerializer setValue:self.cookieId forHTTPHeaderField:@"cookieId"];
    
    NSDictionary *param1 = @{@"sinceId":@(1),
                             @"maxId":@(10),
                             @"type":@"new"};

    [self.manager POST:@"https://api.jieshuibao.com/onlook/look/list" parameters:param1 headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            NSLog(@"success---------------666---%@",responseObject);


        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"-----error----------666---%@",error);

        }];
    
}

- (void)loginTest{
    
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", @"text/xml", @"image/*", nil];
    
    //设置请求头信息
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    
    
    
    NSDictionary *headerFieldValueDictionary = @{
                                                 @"Accept" : @"application/json",
                                                 @"Content-Type" : @"application/json;charset=utf-8;",
                                                 @"cookieId" : (self.cookieId ? self.cookieId : @""),
                                                 @"version": @"2"
                                                 };
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [self.manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    self.manager.requestSerializer = requestSerializer;

    // 设置超时
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval = 100.f;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    // https
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    self.manager.securityPolicy = securityPolicy;
    
    NSString *pwd = @"123456";
    
    NSDictionary *param1 = @{@"phoneNumber": @"13717557625",
                             @"deviceType":@0,
                             @"pwd":[pwd hyb_toMD5]};
    
    [self.manager POST:@"https://api.jieshuibao.com/login" parameters:param1 headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"success---------------999---%@",responseObject);
        //           [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"cookieId"] forKey:@"cookieId"];
        //           [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        self.cookieId = responseObject[@"cookieId"];
        //           [NetManager refreshCookieId:responseObject[@"cookieId"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-----error----------999---%@",error);
        
    }];
}
#pragma mark 自定义manager
- (void)test1{
    
        NSDictionary *param1 = @{@"sinceId":@(1),
                                    @"maxId":@(10),
                                    @"type":@"new"};

     
     
     [[NetManager shareManager] POST:@"onlook/look/list" parameters:param1 headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"success---------------666---%@",responseObject);
    
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"-----error----------666---%@",error);

         }];
}
- (void)login{
    

    NSString *pwd = @"123456";
    
    NSDictionary *param1 = @{@"phoneNumber": @"13717557625",
                                     @"deviceType":@0,
                                     @"pwd":[pwd hyb_toMD5]};
    
    [[NetManager shareManager] POST:@"login" parameters:param1 headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"success---------------999---%@",responseObject);
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"cookieId"] forKey:@"cookieId"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        self.cookieId = responseObject[@"cookieId"];
        [NetManager refreshCookieId:responseObject[@"cookieId"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-----error----------999---%@",error);

    }];
}

- (NSString *)decodeURLString:(NSString *)str
{
    return [str stringByRemovingPercentEncoding];
}

@end
