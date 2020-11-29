//
//  GSFileTool.h
//  test
//
//  Created by 邵梦 on 2020/4/22.
//  Copyright © 2020 ZGH. All rights reserved.
//  处理文件缓存

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GSFileTool : NSObject
/**
  删除文件夹所有文件
  @param  directoryPath  文件夹路径

*/
+ (void)removeDirectoryPath:(NSString *)directoryPath;
/**
   获取文件夹尺寸
   @param  directoryPath  文件夹路径
 
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;
@end

NS_ASSUME_NONNULL_END
