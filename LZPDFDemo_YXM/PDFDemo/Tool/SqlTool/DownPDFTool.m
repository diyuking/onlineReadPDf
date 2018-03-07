//
//  DownPDFTool.m
//  PDFDemo
//
//  Created by k on 2018/2/27.
//  Copyright © 2018年 wiseisland. All rights reserved.
//

#import "DownPDFTool.h"
@interface DownPDFTool()
@property (nonatomic, strong)NSURLSessionDownloadTask *myDownloadTask;
@end
@implementation DownPDFTool
SYNTHESIZE_SINGLETON_FOR_CLASS(DownPDFTool)
- (void)downLoadPdfWithUrl:(NSString *)pdfUrlString
          andDestinationBlock:(void (^)(id infoObject))destinationBlock
               andCompletionHandlerBlock:(void (^)(id infoDic))completionHandlerBlock
{
    NSURL *pdfUrl = [NSURL URLWithString:pdfUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:pdfUrl];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer.timeoutInterval = 3.0;
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        NSLog(@"进度条-------> %.2f / %.2f",(float)totalBytesWritten/1024.0/1024.0,(float)totalBytesExpectedToWrite/1024.0/1024.0);
    }];
    _myDownloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        destinationBlock([NSURL fileURLWithPath:fullPath]);
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSString *filePadthSring = [NSString stringWithFormat:@"%@",filePath];
        BOOL isAddSuccessBool =  [PDFSqlTool addPdfInfoWithPdfPatch:filePadthSring andCurrect:@"1" andPdfUrl:pdfUrlString];
        if(isAddSuccessBool)
        {
            NSLog(@"缓存信息---->%@",[PDFSqlTool getPdfInfoDicWithPdfUrlString:pdfUrlString]);
        }
        [PDFSqlTool updatePdfCurrectPageWithPdfUrlString:pdfUrlString andfilePath:filePadthSring];
        completionHandlerBlock([PDFSqlTool getPdfInfoDicWithPdfUrlString:pdfUrlString]);
    }];
    [_myDownloadTask resume];
}
//重新下载
- (void)restartDownLoad
{
    if(_myDownloadTask)[_myDownloadTask resume];
}
//暂停
- (void)suspendDownload
{
    if(_myDownloadTask)[_myDownloadTask suspend];
}
@end
