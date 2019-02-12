//
//  NSDate+MYAdd.h
//  Weiji
//
//  Created by LuYang on 16/6/22.
//  Copyright © 2016年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MYAdd)
- (NSDate *)dateBySubingDays:(NSInteger)days;
- (NSDate *)dateBySubingWeeks:(NSInteger)weeks;
- (NSString *)getDescTime;


//字符串转NSDate
+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format;

// NSDate转时间戳
+ (NSInteger)cTimestampFromDate:(NSDate *)date;

//字符串转时间戳
+(NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format;

//时间戳转字符串
+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format;

+(NSString *)timeWithTimeIntervalSecondString:(NSString *)timeString;

//时间戳转化为时间NSDate
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString;

//NSDate转字符串
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format;

//转化成距离当前时间是多少
+(NSString *)judgeTimeWith:(NSString *)tempStr;

+(NSString *)timeWithTimeIntervalYearString:(NSString *)timeString DateFormat:(NSString *)DateFormat;

+(NSString *)timeWithTimeIntervalYearString:(NSString *)timeString;

@end
