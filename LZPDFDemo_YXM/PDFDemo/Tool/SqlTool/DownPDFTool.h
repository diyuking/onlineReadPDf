//
//  DownPDFTool.h
//  PDFDemo
//
//  Created by k on 2018/2/27.
//  Copyright © 2018年 wiseisland. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DownPDFTool : NSObject

+ (DownPDFTool *)sharedDownPDFTool;
- (void)downLoadPdfWithUrl:(NSString *)pdfUrlString
      andDestinationBlock:(void (^)(id infoObject))destinationBlock
    andCompletionHandlerBlock:(void (^)(id infoDic))completionHandlerBlock;
//重新下载
- (void)restartDownLoad;
//暂停
- (void)suspendDownload;
@end
