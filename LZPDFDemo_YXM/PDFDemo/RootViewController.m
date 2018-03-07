//
//  RootViewController.m
//  PDFDemo
//
//  Created by yu on 2018/2/26.
//  Copyright © 2018年 wiseisland. All rights reserved.
//

#import "RootViewController.h"
#import "PDFReaderViewController.h"

@interface RootViewController ()<ReaderViewControllerDelegate,UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;


@end

@implementation RootViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor yellowColor]];
    btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2.0, 100, 100, 40);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"查看" forState:UIControlStateNormal];
    btn.tag = 100;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClick:(UIButton *)senderBtn{
    ReaderViewController *readerVC = [[ReaderViewController alloc] init];
    readerVC.pdfurlSring =  @"https://www.tutorialspoint.com/ios/ios_tutorial.pdf";
    readerVC.title = @"pdf 阅读";
    readerVC.delegate = self;
    [self.navigationController pushViewController:readerVC animated:YES];
}

-(void)dismissReaderViewController:(ReaderViewController *)viewController{
    [self.navigationController popViewControllerAnimated:YES];
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
