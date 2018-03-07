//
//  PDFSqlTool.h
//  PDFDemo
//
//  Created by k on 2018/2/27.
//  Copyright © 2018年 wiseisland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

#define FILEPATH @"filePath"
#define PDFURL @"pdfurl"
#define CURRECTPAGE @"currectpage"
@interface PDFSqlTool : NSObject
/**
 *  添加数据
 *
 *  @param filePatchString 文件路径
 *  @param currectPageString 缓存阅读页码
 *  @parm pdfUrlString pdf的url地址
 *  @return BOOL
 */
+ (BOOL)addPdfInfoWithPdfPatch:(NSString *)filePatchString
                    andCurrect:(NSString *)currectPageString
                     andPdfUrl:(NSString *)pdfUrlString;
/**
 *  更新数据
 *
 *  @param pdfUrlString url路径
 *  @param currectPage 缓存页码
 *
 *  @return BOOL
 */
+ (BOOL)updatePdfCurrectPageWithPdfUrlString:(NSString *)pdfUrlString
                              andCurrectPage:(NSString *)currectPage;
/**
 *  更新数据
 *
 *  @param pdfUrlString url路径
 *  @param filePathString 文件路径
 *
 *  @return BOOL
 */
+ (BOOL)updatePdfCurrectPageWithPdfUrlString:(NSString *)pdfUrlString
                                 andfilePath:(NSString *)filePathString;
/**
 *  更新目录
 *
 *  @param pdfUrlString url路径
 *
 */
+ (void)updateFilePathCatalogWithPdfUrlSting:(NSString *)pdfUrlString;
/**
 *  查询数据
 *
 *  @param pdfUrlString url路径
 *
 *  @return NSMutableDictionary
 */
+ (NSMutableDictionary *)getPdfInfoDicWithPdfUrlString:(NSString *)pdfUrlString;

@end
