//
//  UIView+Frame.h
//  test
//
//  Created by 邵梦 on 2020/3/24.
//  Copyright © 2020 ZGH. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)
@property CGFloat gs_width;
@property CGFloat gs_height;
@property CGFloat gs_x;
@property CGFloat gs_y;
@property CGFloat gs_centerX;
@property CGFloat gs_centerY;
@property CGSize gs_size;
@property CGFloat gs_bottom;

@end

NS_ASSUME_NONNULL_END
