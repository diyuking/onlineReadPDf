//
//  PDFSqlTool.m
//  PDFDemo
//
//  Created by k on 2018/2/27.
//  Copyright © 2018年 wiseisland. All rights reserved.
//

#import "PDFSqlTool.h"

@implementation PDFSqlTool

static FMDatabaseQueue *_queue;

+ (void)initialize
{
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:@"drop table pdf_cachetable"];
    }];
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"note.db"];
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists pdf_cachetable (id INTEGER PRIMARY KEY AUTOINCREMENT,filePath text,pdfurl text,currectpage text);"];
    }];
}
+ (BOOL)addPdfInfoWithPdfPatch:(NSString *)filePatchString
                     andCurrect:(NSString *)currectPageString
                      andPdfUrl:(NSString *)pdfUrlString
{
    filePatchString = [filePatchString stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        result = [db executeUpdate:@"insert into pdf_cachetable (filePath,pdfurl,currectpage) values(?,?,?)",filePatchString,pdfUrlString,currectPageString];
    }];
    return  result;
}
+ (BOOL)updatePdfCurrectPageWithPdfUrlString:(NSString *)pdfUrlString
                              andCurrectPage:(NSString *)currectPage
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        result = [db executeUpdate:@"update pdf_cachetable set currectpage=? where pdfurl=?;",currectPage,pdfUrlString];
    }];
    return  result;
}
+ (BOOL)updatePdfCurrectPageWithPdfUrlString:(NSString *)pdfUrlString
                                 andfilePath:(NSString *)filePathString
{
    __block BOOL result;
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        result = [db executeUpdate:@"update pdf_cachetable set filePath=? where pdfurl=?;",filePathString,pdfUrlString];
    }];
    return  result;
}
+ (NSMutableDictionary *)getPdfInfoDicWithPdfUrlString:(NSString *)pdfUrlString
{
    __block NSMutableDictionary *pdfInfoDic = nil;
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        pdfInfoDic = [NSMutableDictionary dictionaryWithCapacity:0];
        FMResultSet *reset = [db executeQuery:@"select * from pdf_cachetable where pdfurl=? limit 1;",pdfUrlString];
        while (reset.next) {
            NSString *filePath = [reset stringForColumn:FILEPATH];
            NSString *pdfurl = [reset stringForColumn:PDFURL];
            NSString *currectpage = [reset stringForColumn:CURRECTPAGE];
            currectpage = [currectpage stringByReplacingOccurrencesOfString:@" " withString:@""];
            currectpage = currectpage.length ? currectpage : @"1";
            [pdfInfoDic setObject:filePath forKey:FILEPATH];
            [pdfInfoDic setObject:pdfurl forKey:PDFURL];
            [pdfInfoDic setObject:currectpage forKey:CURRECTPAGE];
        }
    }];
    return pdfInfoDic;
}
+ (void)updateFilePathCatalogWithPdfUrlSting:(NSString *)pdfUrlString
{
    NSArray *pdfAry = [pdfUrlString componentsSeparatedByString:@"/"];
    
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:pdfAry.lastObject];
    fullPath = [fullPath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    [PDFSqlTool updatePdfCurrectPageWithPdfUrlString:pdfUrlString andfilePath:fullPath];
}
@end
