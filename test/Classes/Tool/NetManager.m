//
//  NetManager.m
//  
//
//  Created by 边文辉 on 16/10/24.
//  Copyright © 2016年 bianwenhui. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

#pragma mark - Public
+ (instancetype)shareManager
{
    static NetManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        NSString *URLString = [kMainBaseUrl encodeURLString];
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.jieshuibao.com"]];
    });
    return _instance;
}


#pragma mark - init
//- (instancetype)init
//{
//    self = [super init];
//    if (!self) return nil;
//
//    [self setupRequestSerializer];
//
//    return self;
//}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) return nil;
    
    [self setupRequestSerializer];
    
    return self;
}

- (void)setupRequestSerializer {
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", @"text/xml", @"image/*", nil];
    
    //设置请求头信息
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    
    
    NSString *cookieID = [[NSUserDefaults standardUserDefaults] objectForKey:@"cookieId"];
    
    NSDictionary *headerFieldValueDictionary = @{
                                                 @"Accept" : @"application/json",
                                                 @"Content-Type" : @"application/json;charset=utf-8;",
                                                 @"cookieId" : (cookieID ? cookieID : @""),
                                                 @"version": @"2"
                                                 };
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [self.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    self.requestSerializer = requestSerializer;

    // 设置超时
    [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.requestSerializer.timeoutInterval = 100.f;
    [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    // https
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    self.securityPolicy = securityPolicy;
 
}

+ (void)refreshCookieId:(NSString *)cookieId
{
    if ([NetManager shareManager].requestSerializer != nil) {
        
        [[NetManager shareManager].requestSerializer setValue:cookieId forHTTPHeaderField:@"cookieId"];
    }
}

@end
