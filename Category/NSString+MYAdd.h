//
//  NSString+MYAdd.h
//  Foundation
//
//  Created by developer on 16/6/6.
//  Copyright © 2016年 kunxun. All rights reserved.
//

#import <Foundation/Foundation.h>

struct MYTitleInfo {
    NSInteger length;
    NSInteger number;
};
typedef struct MYTitleInfo MYTitleInfo;

@interface NSString (MYAdd)
- (NSString *)subStringWithMaxLength:(NSInteger)maxLength;

//判断中英混合的的字符串长度及字符个数
- (MYTitleInfo)getInfoWithMaxLength:(NSInteger)maxLength;

// 一些简单的字符串处理函数
- (NSString *)trim;
/**
 * 是否是有效的字符串
 */
- (BOOL)isValid;

/*
 获取设备型号
 */
+ (NSString *)getCurrentDeviceModel;

//姓名保护
+ (NSString *)nameToProtectName:(NSString*)nameStr;

/*
 获取当前时间
 */
+(NSString *)getCurrentTime;

/*
当前时间戳
 */
+ (NSString *)getCurrentTimeStamp;

//当前时间和某个历史时间戳相差的时分秒
+(NSString *)pastTimeStap:(NSString *)pastTimeStap;

/*
 验证手机号
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/*
 验证邮箱
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/*
 验证纯数字
 */
+ (BOOL)validationOfPureDigitalString:(NSString *)string;

/*
 验证纯字母
 */
+ (BOOL)validationOfPureAlphabetString:(NSString *)string;

/*
 判断仅输入字母或数字
 */
+ (BOOL)validationOfPureAlphabetAndDigitalString:(NSString *)string;

/*
 6-16位且同时包含数字和字母
 */
+(BOOL)judgePassWordLegal:(NSString *)pass;

//6-16位且可以只是数字或字母
+(BOOL)judgePassWordWithNumberOrCharacter:(NSString *)pass;

//银行卡4位空一位
+ (NSString *)getBlankString:(NSString *)str;

+ (NSString*)jsonStringOfObj:(NSDictionary*)dic;

//判断输入框首位不是0，且输入的是正整数
+(BOOL)judgeStringIsNSUNumberAndFristCharNoZero:(NSString *)string;

/*
 json 字符串转字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

/*
 字典转 json
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//获取总容量
+ (NSString *)getDivceSize;

/*
 设置字符串的行间距和字间距
 */
+(NSMutableAttributedString *)setTextLineSpace:(CGFloat)lineSpace paragraphSpace:(CGFloat)paragraphSpace string:(NSString *)string;

/*
 设置字符串中字符的颜色
 */
+ (NSMutableAttributedString *)setTextColorWithString:(NSString *)string colorString:(NSString *)colorString color:(NSString *)color fontSize:(CGFloat)fontSize;

+ (NSMutableAttributedString *)setTextColorWithString:(NSString *)string colorString:(NSString *)colorString color:(NSString *)color fontSize:(CGFloat)fontSize LineSpace:(CGFloat)lineSpace paragraphSpace:(CGFloat)paragraphSpace;

//设置z字符大小
+(NSMutableAttributedString *)setTextFontWithString:(NSString *)string fontsize:(CGFloat)fontsize range:(NSRange)range;

/*
 计算文本的高度
 */
+ (CGFloat)textHeightWithText:(NSString *)string anWidth:(CGFloat)width anfont:(CGFloat)fontSize;

+ (NSString *)contentTypeForImageData:(NSData *)data;

/*
 计算文本宽度
 */
+ (CGFloat)textWidthWithText:(NSString *)string height:(CGFloat)height anfont:(CGFloat)fontSize;

//小写转大写
+(NSString *)toUpper:(NSString *)str;

//大写转小写
+(NSString *)toLower:(NSString *)str;

+ (BOOL)isNewVersion;

//时间戳转自定义格式时间
+ (NSString *)TimeStampToCustomTimeWithFormat:(NSString*)format timeStap:(NSString*)timeStap;

//两个时间戳相差天数
+ (NSInteger)firstTimeStap:(NSString*)firstStamp secondTimeStap:(NSString*)secondTimtStap;

- (void)showNotice;

- (CGSize)sizeOfMaxScreenSizeInFont:(NSInteger)font;

//根据身份证号获取生日
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;

+ (NSString *)getShiYongMoreTime:(NSTimeInterval)time title:(NSString *)tilte title1:(NSString *)tilte1;


- (NSString *)formatFloat:(float)f;

+(CGFloat)getLabelHeightWithContent:(NSString *)content andLabelHeight:(CGFloat)height andLabelFontSize:(int)font;

+(NSString *)replaceUnicode:(NSString*)unicodeStr;


@end
