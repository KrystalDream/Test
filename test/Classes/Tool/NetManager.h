//
//  NetManager.h
//  
//
//  Created by 边文辉 on 16/10/24.
//  Copyright © 2016年 bianwenhui. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetManager : AFHTTPSessionManager

/**
 *  单例
 */
+ (instancetype)shareManager;

/**
 cookid 重新登录后 配置
 */
+ (void)refreshCookieId:(NSString *)cookieId;

@end
