//
//  UIImage+Image.m
//  test
//
//  Created by 邵梦 on 2020/3/20.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "UIImage+Image.h"

//#import <AppKit/AppKit.h>


@implementation UIImage (Image)
+ (UIImage *)imageOriginalNameStr:(NSString *)nameStr{
    
    return [[UIImage imageNamed:nameStr]
            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
