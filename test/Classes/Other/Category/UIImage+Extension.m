//
//  UIImage+Extension.m
//  
//
//  Created by 边文辉 on 16/10/24.
//  Copyright © 2016年 bianwenhui. All rights reserved.
//

#import "UIImage+Extension.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation UIImage (Extension)


- (UIImage *)bwh_scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)bwh_imageCompressForSize:(CGSize)size
{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
//        DeLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

/**
 *  返回指定尺寸的图片
 */
- (UIImage *)bwh_imageWithScaleSize:(CGSize)scaleSize {
    
    UIGraphicsBeginImageContext(scaleSize);
    
    // 指定图片尺寸
    [self drawInRect:(CGRect){CGPointZero,scaleSize}];
    
    // 获取指定尺寸的图片
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return [scaleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

+ (UIImage *)jsb_noRenderingWithImageName:(NSString *)imageName {
    UIImage *tempImage = [UIImage imageNamed:imageName];
    return [tempImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  返回拉伸后的图片,默认为从中点拉伸
 */
+ (UIImage *)bwh_resizeImageWithName:(NSString *)imageName {
    return [self bwh_resizeImageWithName:imageName edgeInsets:UIEdgeInsetsZero];
}

/**
 *  返回拉伸后的图片,指定拉伸位置
 */
+ (UIImage *)bwh_resizeImageWithName:(NSString *)imageName edgeInsets:(UIEdgeInsets)edgeInsets {
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
    return image;
}



/**
 *  将方图片转换成圆图片
 */
+ (UIImage *)bwh_circleImageWithOldImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.开启上下文
    CGFloat border = borderWidth;
    CGFloat imageW = oldImage.size.width + 2 * border;
    CGFloat imageH = oldImage.size.height + 2 * border;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    // 2.取出当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 3.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    // 小圆
    CGFloat smallRadius = bigRadius - border;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, 2 * M_PI, 0);
    CGContextClip(ctx);
    
    // 画图
    [oldImage drawInRect:CGRectMake(border, border, oldImage.size.width, oldImage.size.height)];
    
    // 取图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (UIImage *)bwh_generateCenterImageWithBgColor:(UIColor *)bgImageColor bgImageSize:(CGSize)bgImageSize centerImage:(UIImage *)centerImage
{
    UIImage *bgImage = [UIImage imageWithColor:bgImageColor size:bgImageSize];
    UIGraphicsBeginImageContext(bgImage.size);
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    [centerImage drawInRect:CGRectMake((bgImage.size.width - centerImage.size.width) * 0.5, (bgImage.size.height - centerImage.size.height) * 0.5, centerImage.size.width, centerImage.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

/**
 *  生成一个无颜色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)write2File:(NSString *)filePath
{
    NSData *data = UIImagePNGRepresentation(self);
    [data writeToFile:filePath atomically:YES];
}


+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


/**
 获取图片base64字符串  
 */
- (NSString *)image2Base64StringWithMaxDataSize:(CGFloat)dataMax maxSize:(CGSize)maxSize
{
    CGFloat scale = 1.f;
    CGSize size = CGSizeMake(self.size.width - 1, self.size.height - 1);
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    
    while ([imageData length] > dataMax && (scale > .1f)) {
        scale -= 0.1;
        CGSize newSize = CGSizeMake(size.width * scale, size.height * scale);
        UIImage *smaller = [self bwh_scaleToSize:newSize];
        imageData = UIImageJPEGRepresentation(smaller, 1);
    }
    
    if (scale <= .1f) {
        UIImage *smaller = [self bwh_scaleToSize:maxSize];
        imageData = UIImageJPEGRepresentation(smaller, 1);
    }
    
    return [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

/**
 base64字符串转图片
 */
+ (UIImage *)imageWithBase64String:(NSString *)base64String
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}


/**
 生成分享图片

 @param title 标题
 @param content 内容
 @return 分享图片
 */
+ (UIImage *)imageWithTitle:(NSString *)title withContent:(NSString *)content
{
    UIImage *back = [UIImage imageNamed:@"share_background"];
    
    CGFloat width = back.size.width;
    CGFloat height = back.size.height;
    
    //画布大小
    CGSize size = CGSizeMake(width, height);
    
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);//opaque:NO  scale:0.0
    [back drawAtPoint:CGPointMake(0.0, 0.0)];
    
    /** title */
    //文字居中显示在画布上
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;//文字居中
    
    UIFont *font;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        font = [UIFont fontWithName:@"PingFangSC-Light" size:30.f];
    } else {
        font = [UIFont systemFontOfSize:30.f];
    }
    
    NSDictionary *titleAttrs = @{NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : paragraphStyle,
//                                 NSBackgroundColorAttributeName : [UIColor orangeColor],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    
    
    //计算文字所占的size,文字居中显示在画布上
    CGFloat titleH = [title boundingRectWithSize:back.size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:titleAttrs
                                         context:nil].size.height;
    
    CGFloat titleY = 312.5;  // @2x 625
    CGRect titleRect = CGRectMake(0, titleY, width, titleH);
    
    //绘制文字
    [title drawInRect:titleRect withAttributes:titleAttrs];
    
    
    
    /** content */
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *contentAttrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16.f],
                                   NSParagraphStyleAttributeName : paragraphStyle,
//                                   NSBackgroundColorAttributeName : [UIColor orangeColor],
                                   NSForegroundColorAttributeName : [UIColor blackColor]};
    
    CGFloat contentX = 30;
    CGFloat contentY = CGRectGetMaxY(titleRect) + 22;
    
    CGSize boundingSize = CGSizeMake(width - contentX * 2, height);
    CGSize contentSize = [content boundingRectWithSize:boundingSize
                                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:contentAttrs
                                               context:nil].size;
    CGRect contentRect = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    [content drawInRect:contentRect withAttributes:contentAttrs];
    
    
    //返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


/**
 生成分享图片 加颜色
 
 @param title 标题
 @param content 内容 需要自己添加颜色属性 字体
 @return 分享图片
 */
+ (UIImage *)imageWithTitle:(NSString *)title withAttributedContent:(NSMutableAttributedString *)content
{
    UIImage *back = [UIImage imageNamed:@"share_background"];
    
    CGFloat width = back.size.width;
    CGFloat height = back.size.height;
    
    //画布大小
    CGSize size = CGSizeMake(width, height);
    
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);//opaque:NO  scale:0.0
    [back drawAtPoint:CGPointMake(0.0, 0.0)];
    
    /** title */
    //文字居中显示在画布上
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;//文字居中
    
    UIFont *font;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        font = [UIFont fontWithName:@"PingFangSC-Light" size:30.f];
    } else {
        font = [UIFont systemFontOfSize:30.f];
    }
    
    NSDictionary *titleAttrs = @{NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : paragraphStyle,
                                 //                                 NSBackgroundColorAttributeName : [UIColor orangeColor],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    
    CGFloat titleH = [title boundingRectWithSize:back.size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:titleAttrs
                                         context:nil].size.height;
    
    CGFloat titleY = 307.5;  // @2x 615
    CGRect titleRect = CGRectMake(0, titleY, width, titleH);
    
    [title drawInRect:titleRect withAttributes:titleAttrs];
    
    
    
    /** content */
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 5.f;
    [content addAttributes:@{NSParagraphStyleAttributeName : paragraphStyle,
//                             NSFontAttributeName : [UIFont boldSystemFontOfSize:16.f]
                             }
                     range:NSMakeRange(0, content.length)];
    
    CGFloat contentX = 30;
    CGFloat contentY = CGRectGetMaxY(titleRect) + 19;
    CGSize boundingSize = CGSizeMake(width - contentX * 2, height);
    CGSize conSize = [content boundingRectWithSize:boundingSize
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           context:nil].size;
    
    CGRect contentRect = CGRectMake(contentX, contentY, conSize.width, conSize.height);
    [content drawInRect:contentRect];
    
    //返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}





+ (UIImage *)imageWithColor:(UIColor *)color radius:(CGFloat)radius {
    UIImage *image = [UIImage imageWithColor:color];
    return [image imageWithCornerRadius:(CGFloat)radius];
}


@end
