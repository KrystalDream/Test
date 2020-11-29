//
//  UIBarButtonItem+Item.m
//  test
//
//  Created by 邵梦 on 2020/3/24.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

//#import <AppKit/AppKit.h>


@implementation UIBarButtonItem (Item)
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(nullable id)target action:(SEL)action{
    UIButton *btn = [UIButton new];
    [btn setImage : image forState:UIControlStateNormal];
    [btn setImage : highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget : target
            action : action
  forControlEvents : UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView : btn];
    
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage addTarget:(nullable id)target action:(SEL)action{
    UIButton *btn = [UIButton new];
    [btn setImage : image forState:UIControlStateNormal];
    [btn setImage : selectedImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget : target
            action : action
  forControlEvents : UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView : btn];
    
}
//有中文的参数 放在最后一个 以免没有提示
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage addTarget:(nullable id)target action:(SEL)action title:(NSString *)title{
    
        UIButton *btn = [UIButton new];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn sizeToFit];

        //让按钮贴着左边
        //正数就是距相应的边的距离增加，负数就是距相应的距离减少
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    //    btn.imageEdgeInsets =
    //    btn.titleEdgeInsets =
         [btn addTarget : target
                  action : action
        forControlEvents : UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView : btn];

    
}
@end
