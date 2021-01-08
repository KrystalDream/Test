//
//  UITextField+PlaceHolder.m
//  test
//
//  Created by Krystal on 2021/1/7.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "UITextField+PlaceHolder.h"
#import <objc/message.h>

@implementation UITextField (PlaceHolder)
+ (void)load{
    //Instance  实例方法
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setGSPlaceholderMethod = class_getInstanceMethod(self, @selector(setGSPlaceholder:));

    method_exchangeImplementations(setPlaceholderMethod, setGSPlaceholderMethod);
}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    
    //分析：为什么先设置占位文字颜色，就没有效果   ------> 占位文字的label 拿不到 （OC是懒加载机制 ：没设置占位文字，不会创建这个控件）
    
    //解决：给成员属性赋值  runtime 给系统的类添加成员属性  （目的 把颜色保存起来）
    objc_setAssociatedObject(self, @"placeHolderColor", placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeHolderLabel = [self valueForKey:@"placeholderLabel"];
    placeHolderLabel.textColor = placeHolderColor;
    
    
}
- (UIColor *)placeHolderColor{
//    return nil;
    return objc_getAssociatedObject(self, @"placeHolderColor");
}
- (void)setGSPlaceholder:(NSString *)placeholder{
//    self.placeholder = placeholder;
    [self setGSPlaceholder:placeholder];
    self.placeHolderColor = self.placeHolderColor;
    
}
@end
