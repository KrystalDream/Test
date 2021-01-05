//
//  GSLoginRegisterView.m
//  test
//
//  Created by Krystal on 2021/1/5.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "GSLoginRegisterView.h"

@interface GSLoginRegisterView ()
//xib 必须绑定页面 否则不能拖线

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation GSLoginRegisterView
//创建 xib  同名view ;   size：freeform    topBar : None
//xib 中 imageview 不可以添加子控件  （解决方法：设置相同大小的view 在view 上添加）
+(instancetype)loginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
+(instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//从xib 加载
- (void)awakeFromNib{
   //让我的按钮图片不拉伸(我没有用图片 暂时注释掉)
    
//    UIImage *image =  _loginBtn.currentBackgroundImage;
//    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
//    [_loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
}

@end
