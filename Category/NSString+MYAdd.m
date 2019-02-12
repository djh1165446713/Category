//
//  NSString+MYAdd.m
//  Foundation
//
//  Created by developer on 16/6/6.
//  Copyright © 2016年 kunxun. All rights reserved.
//

#define NUMBERS @"0123456789\n"

#import "NSString+MYAdd.h"
#import "sys/utsname.h"
#include <sys/param.h>
#include <sys/mount.h>

@implementation NSString (MYAdd)
- (NSString *)subStringWithMaxLength:(NSInteger)maxLength {
    __block NSString *aString = @"";
    __block int length = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        char *p = (char *)[substring cStringUsingEncoding:NSUnicodeStringEncoding];
        for (int i = 0; i < [substring lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
            if (*p && p != '\0') {
                length++;
            }
            p++;
        }
        if (length <= maxLength) {
            aString = [aString stringByAppendingString:substring];
        }
    }];
    
    return aString;
}


//判断中英混合的的字符串长度及字符个数
- (MYTitleInfo)getInfoWithMaxLength:(NSInteger)maxLength {
    MYTitleInfo title;
    int length = 0;
    int singleNum = 0;
    int totalNum = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p && p != '\0') {
            length++;
            if (length <= maxLength) {
                totalNum++;
            }
        }
        else {
            if (length <= maxLength) {
                singleNum++;
            }
        }
        p++;
    }
    
    title.length = length;
    title.number = (totalNum - singleNum) / 2 + singleNum;
    
    return title;
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - common methods
+ (NSString*)jsonStringOfObj:(NSDictionary*)dic{
    NSError *err = nil;
    
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:dic
                                                         options:0
                                                           error:&err];
    
    NSString *str = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    return str;
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                NULL,
                                                                                                (CFStringRef)input,
                                                                                                NULL,
                                                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                kCFStringEncodingUTF8 ));
    return outputStr;
    
}


/**
 * 是否是有效的字符串
 */
- (BOOL)isValid
{
    return self && [self isKindOfClass:[NSString class]] && [[self trim] length] > 0;
}

//当前时间
+(NSString *)getCurrentTime{
//    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
//    NSString *dateString = [dateFormatter stringFromDate:currentDate];
//    return dateString;
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:currentDate];
}

//  当前时间戳
+ (NSString *)getCurrentTimeStamp {
    return [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}

//验证手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700,173
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|73|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//银行卡4位空一位
+ (NSString *)getBlankString:(NSString *)str{
    
    NSString *text = str;
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([text length] >= 21) {
        
    }
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    return newString;
    
}

//邮箱地址的正则表达式
+ (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//验证纯数字
+ (BOOL)validationOfPureDigitalString:(NSString *)string
{
//    NSString *regex = @"(/^[0-9]*$/)";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    if (![pred evaluateWithObject:string]) {
//        
//        return YES;
//    }
//    return NO;
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
}

//验证纯字母
+ (BOOL)validationOfPureAlphabetString:(NSString *)string
{
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:string]) {
        
        return YES;
    }
    return NO;
}

//判断仅输入字母或数字
+ (BOOL)validationOfPureAlphabetAndDigitalString:(NSString *)string
{
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:string]) {
        return YES;
    }
    return NO;
}

//验证纯汉字
+ (BOOL)validationOfPureChineseString:(NSString *)string
{
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:string]) {
        
        return YES;
    }
    return NO;
}

//6-16位且同时包含数字和字母
+(BOOL)judgePassWordLegal:(NSString *)pass
{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//6-16位且可以只是数字或字母
+(BOOL)judgePassWordWithNumberOrCharacter:(NSString *)pass
{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"[0-9A-Za-z]{6,12}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//判断输入框首位不是0，且输入的是正整数
+(BOOL)judgeStringIsNSUNumberAndFristCharNoZero:(NSString *)string
{
    BOOL result = false;
    NSString * regex = @"/^[1-9]*$/";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:string];
    
    return result;
}


//json 字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//姓名保护
+ (NSString *)nameToProtectName:(NSString*)nameStr{
    if (nameStr) {
        NSString *laststr = [nameStr substringFromIndex:nameStr.length-1];
        return [@"**" stringByAppendingString:laststr];
    }
    return nameStr;
}

//字典转 json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//设置字符串的行间距和字间距
+(NSMutableAttributedString *)setTextLineSpace:(CGFloat)lineSpace paragraphSpace:(CGFloat)paragraphSpace string:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&paragraphSpace);
    [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
    //清除CFNumberRef
    CFRelease(num);
    
    return attributedString;
}

//设置字符串中字符的颜色
+ (NSMutableAttributedString *)setTextColorWithString:(NSString *)string colorString:(NSString *)colorString color:(NSString *)color fontSize:(CGFloat)fontSize
{
    NSRange rangeRmb = [string rangeOfString:colorString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:nil];
    NSDictionary *fontDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:color],NSForegroundColorAttributeName,[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil];
    [attributedString addAttributes:fontDic range:rangeRmb];
    return attributedString;
}

//设置字符串中字符的颜色大小和间距
+ (NSMutableAttributedString *)setTextColorWithString:(NSString *)string colorString:(NSString *)colorString color:(NSString *)color fontSize:(CGFloat)fontSize LineSpace:(CGFloat)lineSpace paragraphSpace:(CGFloat)paragraphSpace{
    NSRange rangeRmb = [string rangeOfString:colorString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:color] range:rangeRmb];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:rangeRmb];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&paragraphSpace);
    [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
    //清除CFNumberRef
    CFRelease(num);
    
    return attributedString;
}

//设置z字符大小
+(NSMutableAttributedString *)setTextFontWithString:(NSString *)string fontsize:(CGFloat)fontsize range:(NSRange)range{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:nil];
    NSDictionary *fontDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontsize],NSFontAttributeName, nil];
    [attributedString addAttributes:fontDic range:range];
    return attributedString;
    
}

// 判断图片类型
+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}




//计算文本的高度
+ (CGFloat)textHeightWithText:(NSString *)string anWidth:(CGFloat)width anfont:(CGFloat)fontSize
{
    UIFont * tfont = [UIFont systemFontOfSize:fontSize];
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    CGSize size =CGSizeMake(width,INT_MAX);
    NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
    CGSize realSize = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:tfont,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return realSize.height;
}

//计算文本宽度
+ (CGFloat)textWidthWithText:(NSString *)string height:(CGFloat)height anfont:(CGFloat)fontSize
{
    UIFont * tfont = [UIFont systemFontOfSize:fontSize];
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    CGSize size = CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX);
    //获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize.width;
}


+(CGFloat)getLabelHeightWithContent:(NSString *)content andLabelHeight:(CGFloat)height andLabelFontSize:(int)font{
    CGSize size = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}

//小写转大写
+(NSString *)toUpper:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='a'&[str characterAtIndex:i]<='z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]-32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

//大写转小写
+(NSString *)toLower:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='A'&[str characterAtIndex:i]<='Z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]+32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

#pragma mark - 判断程序是否是最新版本,从而判断是否需要进入引导界面
+ (BOOL)isNewVersion{
    
    //获取之前版本,与当前版本比较
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version_key"];
    
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *nowVersion = dict[@"CFBundleShortVersionString"];
    
    if ([oldVersion isEqualToString:nowVersion]) {
        
        return NO;
        
    }else{
        //保存当前最新版本
        [[NSUserDefaults standardUserDefaults] setObject:nowVersion forKey:@"version_key"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    
}

//时间戳转自定义格式时间
+ (NSString *)TimeStampToCustomTimeWithFormat:(NSString*)format timeStap:(NSString*)timeStap{
    // iOS 生成的时间戳是10位
    if ([(NSString *)timeStap isKindOfClass:[NSNull class]]) {
        timeStap = [NSString stringWithFormat:@"%f",[[self getCurrentTimeStamp] doubleValue]*1000];
    }
    NSTimeInterval interval    =[timeStap doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

//两个时间戳相差天数
+ (NSInteger)firstTimeStap:(NSString*)firstStamp secondTimeStap:(NSString*)secondTimtStap{
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *beginTime = [self TimeStampToCustomTimeWithFormat:@"yyy-MM-dd HH:mm:ss"  timeStap:firstStamp];
    NSDate *begineDate = [dateFomatter dateFromString:beginTime];
    NSString *endTime = [self TimeStampToCustomTimeWithFormat:@"yyy-MM-dd HH:mm:ss"  timeStap:secondTimtStap];
    NSDate *endDate = [dateFomatter dateFromString:endTime];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // time Difference
    NSDateComponents *dateCom = [calendar components:unit fromDate:begineDate toDate:endDate  options:0];
    return dateCom.day;
}

//当前时间和某个历史时间戳相差的时分秒
+(NSString *)pastTimeStap:(NSString *)pastTimeStap{
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //现在时间戳
    NSString *beginTime = [self TimeStampToCustomTimeWithFormat:@"yyy-MM-dd HH:mm:ss"  timeStap:[self getCurrentTimeStamp]];
    NSDate *begineDate = [dateFomatter dateFromString:beginTime];
    
    //过去时间戳
    NSString *endTime = [self TimeStampToCustomTimeWithFormat:@"yyy-MM-dd HH:mm:ss"  timeStap:pastTimeStap];
    NSDate *endDate = [dateFomatter dateFromString:endTime];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // time Difference
    NSDateComponents *dateCom = [calendar components:unit fromDate:endDate toDate:begineDate  options:0];
    return [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",dateCom.hour,dateCom.minute,dateCom.second];
}

+ (NSString *)getDivceSize{
    //可用大小
//    struct statfs buf;
//    long long freespace = -1;
//    if(statfs("/var", &buf) >= 0){
//        freespace = (long long)(buf.f_bsize * buf.f_bfree);
//    }
    //总大小
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    NSString * sizeStr = [NSString stringWithFormat:@"%.0f",(double)freeSpace/1024/1024/1024];
    NSString *customStr = [self customGBWith:sizeStr];
    return customStr;
}

+ (NSString *)customGBWith:(NSString *)sizeStr{
    if ([sizeStr intValue]<=16) {
        return @"16GB";
    }
    
    if ([sizeStr intValue]<=32) {
        return @"32GB";
    }
    
    if ([sizeStr intValue]<=64) {
        return @"64GB";
    }
    
    if ([sizeStr intValue]<=128) {
        return @"128GB";
    }
    
    if ([sizeStr intValue]<=256) {
        return @"256GB";
    }
    
    if ([sizeStr intValue]<=512) {
        return @"512GB";
    }
    
    return @"";
}

- (void)showNotice{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:self
                                                      delegate:self
                                             cancelButtonTitle:@"知道了"
                                             otherButtonTitles:nil];
    
    
    [alertView show];
}

- (CGSize)sizeOfMaxScreenSizeInFont:(NSInteger)font {
    
    return [self boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
}

//根据身份证号获取生日
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    
    year = [numberStr substringWithRange:NSMakeRange(6, 4)];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
//    [result appendString:@"."];
    [result appendString:month];
//    [result appendString:@"."];
    [result appendString:day];
    return result;
}

//根据秒算时间
+ (NSString *)getShiYongMoreTime:(NSTimeInterval)time title:(NSString *)tilte title1:(NSString *)tilte1{
    
    //分钟
    NSInteger mm = time/60;
    
    //小时
    NSInteger HH = time/3600;
    
    //天数
    NSInteger dd = HH/24;
    
    //剩余的小时数
    NSInteger hh1 = HH - dd * 24;
    
    //剩余得分钟
    NSInteger mm1 = mm - dd * 24 * 60 - hh1 * 60;
    
    //剩余的秒数
    NSInteger ss = time - dd * 24 * 60 * 60 - hh1 * 60 * 60 - mm1 * 60;
    
    NSString *hh1String = [NSString stringWithFormat:@"%@",@(hh1)];
    if (hh1 < 10) {
        hh1String = [NSString stringWithFormat:@"0%@",@(hh1)];
    }
    
    NSString *mm1String = [NSString stringWithFormat:@"%@",@(mm1)];
    if (mm1 < 10) {
        mm1String = [NSString stringWithFormat:@"0%@",@(mm1)];
    }
    
    NSString *ssString = [NSString stringWithFormat:@"%@",@(ss)];
    if (ss < 10) {
        ssString = [NSString stringWithFormat:@"0%@",@(ss)];
    }
    if (dd>0) {
        return [NSString stringWithFormat:@"%@ %@ 天 %@:%@:%@ %@",tilte,@(dd),hh1String,mm1String,ssString,tilte1];
    }else{
        return [NSString stringWithFormat:@"%@ %@:%@:%@ %@",tilte,hh1String,mm1String,ssString,tilte1];
    }
}

+ (NSString *)getCurrentDeviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}


- (NSString *)formatFloat:(float)f
{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}

+(NSString *)replaceUnicode:(NSString*)unicodeStr{
    NSString *tempStr1=[unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2=[tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3=[[@"\"" stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData=[tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr =[NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}
@end
