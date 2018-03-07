//
//  NSString+Extent.m
//  PDFDemo
//
//  Created by k on 2018/3/6.
//  Copyright © 2018年 wiseisland. All rights reserved.
//

#import "NSString+Extent.h"

@implementation NSString (Extent)
+ (NSString *)removeSpaceStringWithString:(NSString *)string
{
    if(!string.length)
    {
        return @"";
    }
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    return string;
}
+(void)getCurrectTime:(NSString *)hixString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//定义时间为这种格式： YYYY-MM-dd hh:mm:ss 。
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];//将NSDate  ＊对象 转化为 NSString ＊对象。
    NSLog(@"%@:%@",hixString, currentTime);//控制台打印出当前时间。
}
@end
