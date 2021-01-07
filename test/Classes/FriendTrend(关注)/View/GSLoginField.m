//
//  GSLoginField.m
//  test
//
//  Created by Krystal on 2021/1/7.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "GSLoginField.h"
#import "UITextField+PlaceHolder.h"

@implementation GSLoginField

/*
   1、文本框边框 变成白色
   2、文本框开始编辑的时候 ，占位文字颜色变成白色
*/
- (void)awakeFromNib{
    [super awakeFromNib];

    //设置光标颜色为白色
    self.tintColor = [UIColor whiteColor];
    
    //监听文本框编辑  1、代理  2、通知  3、target
    //原则：开发中，不要自己成为自己的代理 （因此方法一 不可取）
    //self.delegate = self;
    //通知一对多  还要移除 比较麻烦
    //开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    //结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dic];
    
    //获取占位文字控件
//    UILabel *placeHolderLabel = [self valueForKey:@"placeholderLabel"];
//    placeHolderLabel.textColor = [UIColor redColor];
    
    self.placeHolderColor =  [UIColor redColor];
}
//文本框开始编辑时 调用
- (void)textBegin{
    //设置占位文字 变成白色
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dic];
    
//    UILabel *placeHolderLabel = [self valueForKey:@"placeholderLabel"];
//    placeHolderLabel.textColor = [UIColor whiteColor];
    
    self.placeHolderColor =  [UIColor whiteColor];

    
}
//文本框结束编辑时 调用
- (void)textEnd{
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dic];
    
//    UILabel *placeHolderLabel = [self valueForKey:@"placeholderLabel"];
//    placeHolderLabel.textColor = [UIColor redColor];
    
    self.placeHolderColor =  [UIColor redColor];

}
@end
