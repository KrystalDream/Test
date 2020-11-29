//
//  UIView+Frame.m
//  test
//
//  Created by 邵梦 on 2020/3/24.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "UIView+Frame.h"

//#import <AppKit/AppKit.h>


@implementation UIView (Frame)
- (void)setGs_height:(CGFloat)gs_height{
    
    CGRect rect = self.frame;
    rect.size.height = gs_height;
    self.frame = rect;
    
}
- (CGFloat)gs_height{
    
    return self.frame.size.height;
}

- (void)setGs_width:(CGFloat)gs_width{
    CGRect rect = self.frame;
    rect.size.width = gs_width;
    self.frame = rect;
    
}
- (CGFloat)gs_width{
    
    
    return self.frame.size.width;
}

- (void)setGs_x:(CGFloat)gs_x{
    CGRect rect = self.frame;
    rect.origin.x = gs_x;
    self.frame = rect;
    
}
- (CGFloat)gs_x{
    return self.frame.origin.x;
}

- (void)setGs_y:(CGFloat)gs_y{

    CGRect rect = self.frame;
    rect.origin.y = gs_y;
    self.frame = rect;
}
-( CGFloat)gs_y{
    return self.frame.origin.y;
}
- (void)setGs_centerX:(CGFloat)gs_centerX{
    CGPoint center = self.center;
    center.x = gs_centerX;
    self.center = center;
}
- (CGFloat)gs_centerX{
    return self.center.x;
}
- (void)setGs_centerY:(CGFloat)gs_centerY{
    CGPoint center = self.center;
    center.y = gs_centerY;
    self.center = center;
    
}
- (CGFloat)gs_centerY{
    return self.center.y;

}
- (void)setGs_size:(CGSize)gs_size{
    CGRect frame = self.frame;
    frame.size = gs_size;
    self.frame = frame;
}
- (CGSize)gs_size{
    return self.frame.size;

}
- (void)setGs_bottom:(CGFloat)gs_bottom{
    CGRect frame = self.frame;
    frame.origin.y = gs_bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)gs_bottom{
    return self.frame.origin.y + self.frame.size.height;

}
@end
