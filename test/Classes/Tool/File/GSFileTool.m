//
//  GSFileTool.m
//  test
//
//  Created by 邵梦 on 2020/4/22.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSFileTool.h"

@implementation GSFileTool
+ (void)removeDirectoryPath:(NSString *)directoryPath{
    //获取文件管理者
       NSFileManager *mgr = [NSFileManager defaultManager];
    //判断是否是文件夹
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if(!isExist || !isDirectory){
        //抛异常
        NSException *excep = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹的路径 并且路径要存在" userInfo:nil];
        [excep raise];
    }
    
       //获取cache 文件夹下的所有文件  不包括子路径的子路径
       NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
       
       for (NSString *subPath in subPaths) {
           //拼接完成全路径
           NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
           //删除路径
           [mgr removeItemAtPath:filePath error:nil];
       }
}
//是异步  就不要返回值了
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion{
    
    //获取文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
       
    //判断是否是文件夹
    BOOL isDirectory;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];

    if(!isExist || !isDirectory){
        //抛异常
        NSException *excep = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹的路径 并且路径要存在" userInfo:nil];
        [excep raise];
    }
    
    
    //遍历文件夹所有文件 一个个加起来
    //获取  获取全局并发队列 （GCD自带） dispatch_get_global_queue(优先级，未来)
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //获取文件夹下所有的子路径
            NSArray *subPaths = [manager subpathsAtPath:directoryPath];

            NSInteger totalSize = 0 ;
            for(NSString *subPath in subPaths){
                //获取到文件的全路径
        //        NSString *filePath = [defulfPath stringByAppendingPathComponent:subPath];
                NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];

                //判断是否是隐藏文件
                if([filePath containsString:@".DS"]){
                    continue;
                }
             
                
                //判断是否是文件夹
                BOOL isDirectory;
                BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];

                if(!isExist || isDirectory){
                    continue;
                }
                
                //获取文件属性 attributesOfItemAtPath:只能获取文件的尺寸  文件夹 不可以
                NSDictionary *attr = [manager attributesOfItemAtPath:filePath error:nil];
                NSInteger fileSize = [attr fileSize];
                totalSize += fileSize;
            }
        
        //计算完成回调  回到主线程  因为子线程不能刷新UI
        //这里 同步、异步都可以  同步+主线程不会产生死锁 因为是在子线程中调用
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(completion){
                completion(totalSize);
            }
        });
        
    });
    
    
}
@end
