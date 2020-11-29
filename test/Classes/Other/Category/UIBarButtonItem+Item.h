//
//  UIBarButtonItem+Item.h
//  test
//
//  Created by 邵梦 on 2020/3/24.
//  Copyright © 2020 ZGH. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Item)
//快速创建 UIBarButtonItem

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(nullable id)target action:(SEL)action;


+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(nullable id)target action:(SEL)action title:(NSString *)title;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage addTarget:(nullable id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
