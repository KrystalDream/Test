//
//  UITextField+PlaceHolder.m
//  test
//
//  Created by Krystal on 2021/1/7.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "UITextField+PlaceHolder.h"

@implementation UITextField (PlaceHolder)
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    
    UILabel *placeHolderLabel = [self valueForKey:@"placeholderLabel"];
    placeHolderLabel.textColor = placeHolderColor;
    
    
}
- (UIColor *)placeHolderColor{
    return nil;
}
@end
