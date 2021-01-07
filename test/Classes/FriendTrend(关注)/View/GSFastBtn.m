//
//  GSFastBtn.m
//  test
//
//  Created by Krystal on 2021/1/6.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "GSFastBtn.h"

@implementation GSFastBtn
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置图片位置
    self.imageView.gs_y = 0;
    self.imageView.gs_centerX = self.gs_size.width*0.5;
//    self.imageView,gs_centerX = self.gs_size.width*0.5;
    
    //设置标题位置
    self.titleLabel.gs_y = self.imageView.gs_bottom + 10;
    
    //计算文字宽度, 设置label的宽度
    [self.titleLabel sizeToFit];
    
    self.titleLabel.gs_centerX = self.gs_size.width*0.5;
    
  
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
