//
//  NSString+Extension.m
//  航信办税宝
//
//  Created by 边文辉 on 2016/10/27.
//  Copyright © 2016年 jieshuibao. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (BOOL)nonNullString{
    if (self == nil || [self isEqualToString:@""] || self.length == 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)isBlank:(NSString*)str
{
    BOOL ret = NO;
    if ((str == nil)
        || (str == NULL)
        || [str isKindOfClass:[NSNull class]]
        || ![str isKindOfClass:[NSString class]]
        || ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)) {
        ret = YES;
    }
    
    return ret;
}

- (BOOL)isBlank
{
    if (!self) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [self stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
    
//    NSString *str = [NSString stringWithFormat:@"%@",self];
//
//    if ([str isEqualToString:@""]) {
//        return YES;
//    }
//
//    if ([str isEqualToString:@"<null>"]) {
//        return YES;
//    }
//
//    if ([str isEqualToString:@"(null)"]) {
//        return YES;
//    }
//
//    if ([str isEqualToString:@"<nil>"]) {
//        return YES;
//    }
//
//    if (str == nil || str == NULL) {
//        return YES;
//    }
//
//    if ([str isKindOfClass:[NSNull class]]) {
//        return YES;
//    }
//
//    if ([str isEqual:[NSNull null]]) {
//        return YES;
//    }
//
//    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
//        return YES;
//    }
//
//
//    return NO;
}


+ (BOOL)isPhoneNumber:(NSString *)string
{
    if (![string hasPrefix:@"1"]) {
        return NO;
    }
    NSString * MOBILE = @"^[1-9]\\d{10}$";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return  [regextestMobile evaluateWithObject:string];
}

//+ (BOOL)isTelephones:(NSString *)string
//{
//    NSString * MOBILE = @"^[1-9]\\d{7}$";
//    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    return  [regextestMobile evaluateWithObject:string];
//}

+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^[1][3456789]\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

+ (BOOL)isFixedTelephone:(NSString *)phoneNum {
    
    /**
     
     * 大陆地区固话及小灵通
     
     * 区号：010,020,021,022,023,024,025,027,028,029
     
     * 号码：七位或八位
     
     */
    
    NSString * FT = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", FT];
    
    return [regextestcm evaluateWithObject:phoneNum];
    
}

+ (BOOL)checkTaxNumber:(NSString *)taxNumber {
    if (!taxNumber.length) {
        return NO;
    }
    
    NSString *regex = @"^((\\d{6}[0-9A-Z]{9})|([0-9A-Za-z]{2}\\d{6}[0-9A-Za-z]{10}))$";
//    NSString *regex = @"^((\\d{6}[0-9A-Z]{9})|([0-9A-Za-z]{2}\\d{6}[0-9A-Za-z]{10}))$";
    
    
    
    //  NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(17[0-9]))|\\d{8}$";
    

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:taxNumber];
    return isMatch;

}


+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^[a-zA-Z0-9]{6,15}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}


+ (NSString *)encodeString:(NSString *)string
{
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSString *)decodeString:(NSString *)string
{
    return [string stringByRemovingPercentEncoding];
}

- (NSString *)encodeURLString
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)decodeURLString
{
    return [self stringByRemovingPercentEncoding];
}

//判断是否为整形：
- (BOOL)isPureInt
{
    int val;
    NSScanner* scan = [NSScanner scannerWithString:self];
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
- (BOOL)isPureFloat
{
    float val;
    NSScanner* scan = [NSScanner scannerWithString:self];
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard {
    BOOL flag = NO;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate  predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


//字典转为Json字符串
+(NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



- (NSString *)hyb_toMD5 {
    if (self == nil || [self length] == 0) {
        return @"";
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}


//+(NSString *)switchToTimeStrFromTimestamp:(NSInteger)timestamp
//{
//
//    NSTimeInterval time = timestamp/1000.00;
//
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//
//    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//
//    return [dateFormatter stringFromDate: detaildate];
//}

//+(NSString *)switchToTimeStrFromTimestamp:(NSInteger)timestamp format:(NSString *)format{
//
//    NSTimeInterval time = timestamp/1000.00;
//
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//
//    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
//    [dateFormatter setDateFormat:format?:@"yyyy-MM-dd HH:mm:ss"];
//
//    return [dateFormatter stringFromDate: detaildate];
//}
//
//+(NSInteger)switchToTimestampFromTimeStr:(NSString *)timeStr
//{
//    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//
//    NSDate *date = [dateFormatter dateFromString:timeStr];
//
//    NSString *timeStampStr = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
//
//    return [timeStampStr integerValue];
//}
//+(NSString *)switchToTimeStrFromYMDtamp:(long)timestamp
//{
//
//    NSTimeInterval time = timestamp/1000.00;
//
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//
//    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//
//    return [dateFormatter stringFromDate: detaildate];
//}

//+ (NSString *)witchToTimeStrForDayBefore:(NSInteger)timestamp{
//    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
//    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
//    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
//    NSTimeInterval createTime = timestamp/1000;
//    // 时间差
//    NSTimeInterval time = currentTime - createTime;
//    if(time < 60){
//        return @"刚刚";
//    }
//    //秒转分钟
//    NSInteger minutes = time/60;
//    if(minutes < 60){
//         return [NSString stringWithFormat:@"%ld分钟前",minutes];
//    }
//    // 秒转小时
//    NSInteger hours = time/3600;
//    if (hours<24) {
//        return [NSString stringWithFormat:@"%ld小时前",hours];
//    }
//
//    //秒转月
//    NSInteger months = time/3600/24/30;
//    if (months < 12) {
//          //显示月日
//        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:createTime];
//
//        NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
//        [dateFormatter setDateFormat:@"MM月dd日"];
//
//        return [dateFormatter stringFromDate: detaildate];
//
//    }
//    //显示年月日
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:createTime];
//
//    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
//    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
//
//    return [dateFormatter stringFromDate: detaildate];
//
//}
//+ (NSString *)witchToTimeStrForDayBeforeOtherType:(NSInteger)timestamp{
//    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
//    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
//    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
//    NSTimeInterval createTime = timestamp/1000;
//    // 时间差
//    NSTimeInterval time = currentTime - createTime;
//    if(time < 60){
//        return @"刚刚";
//    }
//    //秒转分钟
//    NSInteger minutes = time/60;
//    if(minutes < 60){
//        return [NSString stringWithFormat:@"%ld分钟前",minutes];
//    }
//    // 秒转小时
//    NSInteger hours = time/3600;
//    if (hours<24) {
//        return [NSString stringWithFormat:@"%ld小时前",hours];
//    }
//
//    //秒转月
//    NSInteger months = time/3600/24/30;
//    if (months < 12) {
//        //显示月日
//        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:createTime];
//
//        NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
//        [dateFormatter setDateFormat:@"MM-dd"];
//
//        return [dateFormatter stringFromDate: detaildate];
//
//    }
//    //显示年月日
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:createTime];
//
//    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//
//    return [dateFormatter stringFromDate: detaildate];
//
//}
//获取字符串的宽度
+(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
     CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName, nil] context:nil].size;

    return sizeToFit.width;
}


+ (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
    
}


+ (BOOL)checkEmailAdress:(NSString *)emailAdress {
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:emailAdress];
    return isMatch;
}


/**
 截取字符串 省略号结尾

 @param index 截取位数
 @return 字符串
 */
- (NSString *)cutStringWithIndex:(NSInteger)index{
    if (self.length <= index + 1) {
        return self;
    }
    NSString *temp = [self substringToIndex:index];
    return [NSString stringWithFormat:@"%@...", temp];
}

- (NSString *)watchNumToTenThousandUnits{
    
    NSString *watchNumStr;
    if(self.integerValue > 10000){
        watchNumStr =  [NSString stringWithFormat:@
                        "%ld万次观看",(long)self.integerValue/10000];
    }else{
        watchNumStr = [NSString stringWithFormat:@"%ld次观看",(long)self.integerValue];
    }
    return watchNumStr;

}


/// 获取播放器时间字符串
/// @param value 进度
/// @param maxTime 最大时间
+ (NSString *)timeProgressWithValue:(float)value maxTime:(NSInteger)maxTime {

    NSInteger currentTime = maxTime * value;
    NSInteger min = 60;
    
    NSString *playSec = [self gainFormatt:currentTime/min];
    NSString *playMin =[self gainFormatt:currentTime%min];
    NSString *durSec = [self gainFormatt:maxTime/min];
    NSString *durMin =[self gainFormatt:maxTime%min];
    
    return [NSString stringWithFormat:@"%@:%@/%@:%@",playSec,playMin,durSec,durMin];
}

+ (NSString *)gainFormatt:(NSInteger)dur {
    return dur <10 ? [NSString stringWithFormat:@"0%ld",(long)dur] :[NSString stringWithFormat:@"%ld",(long)dur];
}

@end





@implementation NSAttributedString (Extension)

/**
 默认阴影字符串 font：12  color：whiteColor
 
 @param string 字符串
 @return 带阴影的字符串
 */
//+ (NSAttributedString *)shadowAttributeStringWithString:(NSString *)string{
//    return [self shadowAttributeStringWithString:string font:FONT_PINGFANG_R(12) textColor:[UIColor whiteColor]];
//}


/**
 带阴影的字符串
 
 @param string 字符串
 @param font 字体
 @param color 字体颜色
 @return 带阴影的字符串
 */
+ (NSAttributedString *)shadowAttributeStringWithString:(NSString *)string font:(NSFont *)font textColor:(UIColor *)color{
    
    NSString *handleStr = [NSString stringWithFormat:@" %@ ",string];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(1,2);
    shadow.shadowBlurRadius = 2.f;//设置模糊度
    shadow.shadowColor = [UIColor colorWithRed:2/255.0 green:2/255.0 blue:2/255.0 alpha:0.15];
    
    NSDictionary *dic = @{NSFontAttributeName:font,NSForegroundColorAttributeName:color};
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:handleStr attributes:dic];
    // 配合使用设置投影
    [attStr addAttribute:NSVerticalGlyphFormAttributeName value:@0 range:NSMakeRange(0, handleStr.length)];
    [attStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, handleStr.length)];
    
    return attStr;
}


/**
 带阴影的字符串
 
 @param string 字符串
 @param font 字体
 @return 带阴影的字符串
 */
+ (NSMutableAttributedString *)shadowAttributeStringWithString:(NSString *)string font:(UIFont *)font{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0,1);
    shadow.shadowBlurRadius = 2.f;//设置模糊度
    shadow.shadowColor = [UIColor colorWithRed:2/255.0 green:2/255.0 blue:2/255.0 alpha:0.15];
    
    NSDictionary *dic = @{NSFontAttributeName:font,NSShadowAttributeName:shadow};
    NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc] initWithString:string attributes:dic];
    
    return mutAttStr;
}


/**
 变色关键字

 @param string 文字内容
 @param keyArr 关键字集合（数组）
 @return 富文本
 */
//+ (NSMutableAttributedString *)attributedStrFromNewString:(NSString *)string keyArr:(NSArray *)keyArr {
//    
//    if (![string nonNullString]) {
//        return [NSMutableAttributedString new];
//    }
//    
//    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
//    
//    //数组去重
//    NSSet *set = [NSSet setWithArray:keyArr];
//    NSArray *arr = [set allObjects];
//
//    for (NSString *keyWord in arr) {
//
//        NSRange range = NSMakeRange(0, string.length);  //查找范围
//        NSRange temp = [string rangeOfString:keyWord options:NSCaseInsensitiveSearch range:range];  //查找结果
//
//        while (temp.location != NSNotFound) { //如果查找结果存在
//
//            [attributedStr addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFA4949) range:temp];
//
//            range = NSMakeRange((temp.location + temp.length), string.length - (temp.location + temp.length)); //更新查找范围
//            temp = [string rangeOfString:keyWord options:NSCaseInsensitiveSearch range:range];  //再次查找
//        }
//    }
//    
////    for (NSString *keyWord in keyArr) {
////        if ([string length] - keyWord.length >= 0) {
////            for (int i = 0; i <= ([string length] - keyWord.length); i++) {
////                if (string.length >= (keyWord.length+i)) {
////                    NSString *tempStr = [string substringWithRange:NSMakeRange(i, keyWord.length)];
////
////                    if ([tempStr isEqualToString:keyWord]) {
////                        [attributedStr addAttribute:NSForegroundColorAttributeName
////                                              value:HEXCOLOR(0xFA4949)
////                                              range:NSMakeRange(i, keyWord.length)];
////                    }
////                }
////            }
////        }
////    }
//    return attributedStr;
//}

@end
