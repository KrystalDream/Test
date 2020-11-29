//
//  NSString+Extension.h
//  航信办税宝
//
//  Created by 边文辉 on 2016/10/27.
//  Copyright © 2016年 jieshuibao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

/**
 * 是否为空
 */
+ (BOOL)isBlank:(NSString *)str;
- (BOOL)isBlank;

/**
 * 是否手机号
 */
//+ (BOOL)isTelephones:(NSString *)string;
+ (BOOL)checkTelNumber:(NSString *) telNumber;

/**
 * 是否电话号码
 */
+ (BOOL)isPhoneNumber:(NSString *)string;


/**
 * 是否6-15位数字和字母组合的密码
 */
+ (BOOL)checkPassword:(NSString *) password;

+ (NSString *)encodeString:(NSString *)string;
+ (NSString *)decodeString:(NSString *)string;
- (NSString *)encodeURLString;
- (NSString *)decodeURLString;

//判断是否为整形：
- (BOOL)isPureInt;

//判断是否为浮点形：
- (BOOL)isPureFloat;

+ (BOOL)validateIdentityCard:(NSString *)identityCard;

+(NSString *)dictionaryToJson:(NSDictionary *)dic;

/**
 *	Convert the string to 32bit md5 string.
 *
 *	@return 32bit md5
 */
- (NSString *)hyb_toMD5;


//
//+(NSString *)switchToTimeStrFromTimestamp:(NSInteger)timestamp;
//
//+(NSString *)switchToTimeStrFromTimestamp:(NSInteger)timestamp format:(NSString *)format;
//
//+(NSInteger)switchToTimestampFromTimeStr:(NSString *)timeStr;
//
///**
// long 转 yyyy-MM-dd
// */
//+(NSString *)switchToTimeStrFromYMDtamp:(long)timestamp;
//
///*
//  毫秒转 几小时 几天 前
// */
//+ (NSString *)witchToTimeStrForDayBefore:(NSInteger)timestamp;
//+ (NSString *)witchToTimeStrForDayBeforeOtherType:(NSInteger)timestamp;
//获取字符串的宽度
+(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;

+ (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;

+ (BOOL)checkTaxNumber:(NSString *)taxNumber;

+ (BOOL)checkEmailAdress:(NSString *)emailAdress;

+ (BOOL)isFixedTelephone:(NSString *)phoneNum;



/**
 截取字符串 省略号结尾
 
 @param index 截取位数
 @return 字符串
 */
- (NSString *)cutStringWithIndex:(NSInteger)index;

/**
 观看次数转成万单位
 @return 字符串
 */
- (NSString *)watchNumToTenThousandUnits;


/**
 判断非空字符串
 @return BOOL
 */
- (BOOL)nonNullString;


/// 获取播放器时间字符串
/// @param value 进度
/// @param maxTime 最大时间
+ (NSString *)timeProgressWithValue:(float)value maxTime:(NSInteger)maxTime;

@end



@interface NSAttributedString (Extension)

/**
 默认阴影字符串 font：12  color：whiteColor

 @param string 字符串
 @return 带阴影的字符串
 */
+ (NSAttributedString *)shadowAttributeStringWithString:(NSString *)string;


/**
 带阴影的字符串

 @param string 字符串
 @param font 字体
 @param color 字体颜色
 @return 带阴影的字符串
 */
+ (NSAttributedString *)shadowAttributeStringWithString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)color;


/**
 带阴影的字符串

 @param string 字符串
 @param font 字体
 @return 带阴影的字符串
 */
+ (NSMutableAttributedString *)shadowAttributeStringWithString:(NSString *)string font:(UIFont *)font;

/**
 变色关键字
 
 @param string 文字内容
 @param keyArr 关键字集合（数组）
 @return 富文本
 */
//+ (NSMutableAttributedString *)attributedStrFromNewString:(NSString *)string keyArr:(NSArray *)keyArr;

@end
NS_ASSUME_NONNULL_END
