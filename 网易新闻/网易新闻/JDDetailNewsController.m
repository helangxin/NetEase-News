//
//  JDDetailNewsController.m
//  网易新闻
//
//  Created by helangxin on 16/4/19.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDDetailNewsController.h"
#import "JDNewsModel.h"
#import <AFHTTPSessionManager.h>

@interface JDDetailNewsController ()<UIWebViewDelegate>
@property (nonatomic, strong) JDNewsModel *news;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSArray *desArr;
@end

@implementation JDDetailNewsController


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate=self;
    [self loadData];
}
/**
 *  加载新闻数据
 */
-(void)loadData
{
    AFHTTPSessionManager*manager=[[AFHTTPSessionManager alloc]init];
    
    [manager GET:self.news.deatilURLString  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary *responseObject)
    {
        NSString*keyRoot=responseObject.keyEnumerator.nextObject;
        self.desArr=responseObject[keyRoot];
//        NSString*path=[[NSBundle mainBundle]pathForResource:@"detail.htmll" ofType:nil];
//        NSURL*url=[NSURL fileURLWithPath:path];
        NSURL*url=[[NSBundle mainBundle]URLForResource:@"detail.htmll" withExtension:nil];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"%@",error);
    }];
}
@end
