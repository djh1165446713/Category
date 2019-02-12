//
//  NSDate+MYAdd.m
//  Weiji
//
//  Created by LuYang on 16/6/22.
//  Copyright © 2016年 developer. All rights reserved.
//

#import "NSDate+MYAdd.h"

@implementation NSDate (MYAdd)
- (NSDate *)dateBySubingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] - 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubingWeeks:(NSInteger)weeks {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] - 86400 * 7 * weeks;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSString *)getDescTime{
    NSDate *now = [NSDate date];
    
    NSInteger nowInt = [now stringWithFormat:@"yyyyMMdd"].integerValue;
    NSInteger selfInt = [self stringWithFormat:@"yyyyMMdd"].integerValue;
    
    if (nowInt == selfInt) {
        return @"今天";
    }
    else if (nowInt - selfInt == 1){
        return @"昨天";
    }
    else{
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay
                                             fromDate:self];
        NSInteger weekDay = [comp weekday];
        NSArray<NSString *> *weekArray = @[@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
        return weekArray[(weekDay - 1)%7];
    }
}


//字符串转NSDate
+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}

// NSDate转时间戳 
+ (NSInteger)cTimestampFromDate:(NSDate *)date
{
    return (long)[date timeIntervalSince1970];
}

//字符串转时间戳
+(NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format
{
    NSDate *date = [NSDate dateFromString:timeStr format:format];
    return [NSDate cTimestampFromDate:date];
}

//时间戳转字符串
+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [NSDate datestrFromDate:date withDateFormat:format];
}

//时间戳转化为时间NSDate
+(NSString *)timeWithTimeIntervalYearString:(NSString *)timeString DateFormat:(NSString *)DateFormat{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:DateFormat];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


//时间戳转化为时间NSDate
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

//NSDate转字符串
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

//时间戳转化为时间NSDate
+(NSString *)timeWithTimeIntervalSecondString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日 hh:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

//时间戳转化为时间NSDate . . .
+(NSString *)timeWithTimeIntervalYearString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)judgeTimeWith:(NSString *)tempStr{
    double tempTime = tempStr.doubleValue;
    double currentTime = [[self getCurrentTimeStamp] doubleValue];
    if (currentTime - tempTime/1000 <= 60) {//刚刚 0-1分钟——刚刚
        return @"刚刚";
    }else if (currentTime - tempTime/1000 > 60 && currentTime - tempTime/1000  <= 3600){//多少分钟前 1-60分钟——n分钟前
        return [NSString stringWithFormat:@"%.0f分钟前",(currentTime - tempTime/1000)/60];
    }else if (currentTime - tempTime/1000 > 3600 && currentTime - tempTime/1000  <= 3600 * 24){//多少小时前 1-24小时——几小时前
        return [NSString stringWithFormat:@"%.0f小时前",(currentTime - tempTime/1000)/(60 * 60)];
    }else if (currentTime - tempTime/1000 > 24*3600 && currentTime - tempTime/1000  < 24*3600*2){//昨天 1-2天，且在昨天——昨天
        return @"昨天";
    }else if (currentTime - tempTime/1000 >= 24*3600*2 && currentTime - tempTime/1000  <= 24*3600*3){//几天前 2-3天——n天前
        return [NSString stringWithFormat:@"%.0f天前",(currentTime - tempTime/1000)/(60 * 60 * 24)];
    }else if (currentTime - tempTime/1000 > 24*3600*3 && currentTime - tempTime/1000  <= 24*3600*365){//今年几月几日
        
        return [self timeWithTimeIntervalString:tempStr];
    }else if (currentTime - tempTime/1000 > 24*3600*365){//哪一年几月几日
        
        return [self timeWithTimeIntervalYearString:tempStr DateFormat:@"YYYY年MM月dd日"];
    }
    return nil;
}

//  当前时间戳
+ (NSString *)getCurrentTimeStamp {
    return [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}


@end
