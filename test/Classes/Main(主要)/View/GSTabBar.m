//
//  GSTabBar.m
//  test
//
//  Created by 邵梦 on 2020/3/23.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSTabBar.h"
#import "UIView+Frame.h"

@interface GSTabBar()
@property (nonatomic, weak) UIButton *plusBtn;
@end

@implementation GSTabBar
- (UIButton *)plusBtn{
    if(!_plusBtn){
//        _plusBtn = [[UIButton alloc] init];
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"icon_ibar_ndex_noclick"] forState:UIControlStateNormal];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"icon_ibar_ndex_click"] forState:UIControlStateHighlighted];
        
        [plusBtn sizeToFit];
        _plusBtn = plusBtn;
        [self addSubview:plusBtn];
        
    }
    return _plusBtn;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    //布局tabBarBtn
    
    NSInteger count = self.items.count + 1;
    CGFloat btnW = self.gs_width/count;//self.bounds.size.width / count;
    CGFloat btnH = self.gs_height;

    NSLog(@"%@",self.subviews);
    
    NSInteger i = 0;
    CGFloat btnX = 0;
    for(UIView *subView in self.subviews){
        // 上面打印出来了 但是拼写报错 说明是私有类  需要手写出来  
        if([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            NSLog(@"%@",subView);
            if( i == 2){
                i = 3;
            }
            btnX = i*btnW;
            subView.frame = CGRectMake(btnX, 0, btnW, btnH);

            i++;
        }
    }
    self.plusBtn.center = CGPointMake(self.gs_width*0.5, self.gs_height*0.5);
    
}

@end
