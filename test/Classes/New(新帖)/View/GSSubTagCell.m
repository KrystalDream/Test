//
//  GSSubTagCell.m
//  test
//
//  Created by 邵梦 on 2020/4/7.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "GSSubTagCell.h"
@interface GSSubTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@end

@implementation GSSubTagCell
- (void)setFrame:(CGRect)frame{
    GSLog(@"--------------%@",NSStringFromCGRect(frame));
    
    frame.size.height -= 10;

    //才是真正去给frame 复制
    [super setFrame:frame];
    
}

//setModel 赋值数据
-(void)setModel:(NSObject *)model{
    _model = model;
    
    self.titleLabel.text = @"strong";
    self.subTitleLabel.text = @"yourself";
    
    //剪裁  --> 上下文
    // 裁剪结果会有锯齿 + 抗锯齿操作 （1像素透明边框）
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1672824262,2727256094&fm=11&gp=0.jpg"]placeholderImage:nil options:SDWebImageFromCacheOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //1、获取上下文
        
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2、描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        //3、设置裁剪区域
        [path addClip];
        //4、画图片
        [image drawAtPoint:CGPointZero];
        //5、取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //6、关闭上下文
        UIGraphicsEndImageContext();
        self.iconImageView.image = image;

    }];
    
}
//什么时候掉用：从xib 加载的时候 会掉用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //设置头像圆角，iOS 9苹果修复
//    self.iconImageView.layer.cornerRadius = 30;
//    self.iconImageView.layer.masksToBounds = YES;
    
    
    self.layoutMargins = UIEdgeInsetsZero;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
