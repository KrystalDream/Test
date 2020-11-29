//
//  UIImage+Extension.h
//  
//
//  Created by 边文辉 on 16/10/24.
//  Copyright © 2016年 bianwenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (Extension)

/** 压缩 */
- (UIImage *)bwh_scaleToSize:(CGSize)size;

/** 等比例压缩 */
- (UIImage *)bwh_imageCompressForSize:(CGSize)size;

/**
 *  返回指定尺寸的图片
 */
- (UIImage *)bwh_imageWithScaleSize:(CGSize)scaleSize;

+ (UIImage *)jsb_noRenderingWithImageName:(NSString *)imageName;

/**
 *  返回拉伸后的图片,默认为从中点拉伸
 */
+ (UIImage *)bwh_resizeImageWithName:(NSString *)imageName;

/**
 *  返回拉伸后的图片,指定拉伸位置
 */
+ (UIImage *)bwh_resizeImageWithName:(NSString *)imageName edgeInsets:(UIEdgeInsets)edgeInset;

/**
 *  将方图片转换成圆图片
 */
+ (UIImage *)bwh_circleImageWithOldImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)bwh_generateCenterImageWithBgColor:(UIColor *)bgImageColor bgImageSize:(CGSize)bgImageSize centerImage:(UIImage *)centerImage;

/**
 *  生成一个无颜色图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;

- (void)write2File:(NSString *)filePath;


- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;


/**
 *颜色转换为图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 获取图片base64字符串
 dataMax 文件大小 bit
 maxSize 图片最大尺寸  暂时不起作用
 */
- (NSString *)image2Base64StringWithMaxDataSize:(CGFloat)dataMax maxSize:(CGSize)maxSize;

/**
 base64字符串转图片
  */
+ (UIImage *)imageWithBase64String:(NSString *)base64String;


/**
// 生成分享图片
// 
// @param title 标题
// @param content 内容
// @return 分享图片
// */
//+ (UIImage *)imageWithTitle:(NSString *)title withContent:(NSString *)content;
//
///**
// 生成分享图片 加颜色
// 
// @param title 标题
// @param content 内容 需要自己添加颜色属性
// @return 分享图片
// */
//+ (UIImage *)imageWithTitle:(NSString *)title withAttributedContent:(NSMutableAttributedString *)content;
//
//
///**
// 生成小鸟图片
// */
//+ (UIImage *)imageWithMoney:(double)money
//                  peekMoney:(double)peekMoney
//                  rewardMoney:(double)rewardMoney
//                  redMoney:(double)redMoney;

/**
 切圆角
 */
-(UIImage*)imageWithCornerRadius:(CGFloat)radius ;
/**
 *颜色转换为有圆角图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color radius:(CGFloat)radius;

@end
