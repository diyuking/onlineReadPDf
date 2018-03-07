//
//  PDFReaderViewController.m
//  PDFDemo
//
//  Created by yu on 2018/2/26.
//  Copyright © 2018年 wiseisland. All rights reserved.
//

#import "PDFReaderViewController.h"
#import "ReaderViewController.h"

@interface PDFReaderViewController () <ReaderViewControllerDelegate>

@end

@implementation PDFReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"pdf = %@",_pdfUrl);
    //判断是否下载过
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"pdfPath"];
    if (dic.count!=0 && [_pdfUrl isEqualToString:dic[@"pdfUrl"]]) {
        //读取
        NSLog(@"读取");

    }else{
        //下载
        [self downLoadPDF];
    }

}

-(void)downLoadPDF{
    __weak typeof(self)weakSelf = self;
    [self.view showLoadingMeg:@"加载中……"];
    [[DownPDFTool sharedDownPDFTool] downLoadPdfWithUrl:_pdfUrl andDestinationBlock:^(id infoObject) {
        [weakSelf.view hideLoading];
        NSLog(@"------->%@",infoObject);
    } andCompletionHandlerBlock:^(id infoDic) {
        [weakSelf.view hideLoading];
        NSLog(@"info -------> %@",infoDic);
        // 1. 实例化控制器
        NSString *path = (NSString *)infoDic[@"filePath"];
        path = [path stringByReplacingOccurrencesOfString:@"file://" withString:@""];
//        ReaderDocument *doc= [[ReaderDocument alloc] initWithFilePath:path password:nil];
        ReaderDocument *doc = [[ReaderDocument alloc] initWithFilePath:path password:nil];
        ReaderViewController *rvc = [[ReaderViewController alloc] initWithReaderDocument:doc];
        rvc.delegate = self;
        // 2. 显示ViewController
      if(rvc)
      {
//        [self presentViewController:rvc animated:YES completion:nil];
          [self.navigationController pushViewController:rvc animated:YES];
      }
    else
    {
        UIAlertView *showAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [showAlert show];
    }
    }];
    
}
- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
