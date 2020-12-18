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
@end

@implementation GSTabBar
- (UIButton *)centerBtn{
    if(!_centerBtn){
//        _centerBtn = [[UIButton alloc] init];
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [centerBtn setBackgroundImage:[UIImage imageNamed:@"icon_ibar_ndex_noclick"] forState:UIControlStateNormal];
//
//        [centerBtn setBackgroundImage:[UIImage imageNamed:@"icon_ibar_ndex_click"] forState:UIControlStateHighlighted];
        
        centerBtn.backgroundColor = [UIColor orangeColor];
        centerBtn.layer.masksToBounds = YES;
        centerBtn.layer.cornerRadius = 25;
        
        [centerBtn sizeToFit];
        _centerBtn = centerBtn;
        [self addSubview:centerBtn];
        
    }
    return _centerBtn;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *view = [super hitTest:point withEvent:event];
    if(view == nil){
        
        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
        if(CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
            
            return self.centerBtn;
        }
    }
    
    return  view;
}
//-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView*view = [super hitTest:point withEvent:event];
//    if(view== nil){
//        //转换坐标
//        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
//
//        //判断点击的点是否在按钮区域内
//
//        if(CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
//        //返回按钮
//            return_centerBtn;
//        }
//    }
//
//    returnview;
//
//}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    //布局tabBarBtn
    
    NSInteger count = self.items.count + 1;
    CGFloat btnW = self.gs_width/count;//self.bounds.size.width / count;
    CGFloat btnH = GSTabBarH;//self.gs_height;

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
//    self.centerBtn.center = CGPointMake(self.gs_width*0.5, self.gs_height*0.5);
//    self.centerBtn.center = CGPointMake(self.gs_width*0.5, GSTabBarH*0.5);
    self.centerBtn.gs_size = CGSizeMake(50,50);
    self.centerBtn.gs_y = - btnH/2;
    self.centerBtn.gs_centerX = self.gs_width*0.5;


}

@end
