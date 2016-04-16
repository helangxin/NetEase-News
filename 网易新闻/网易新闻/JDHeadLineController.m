//
//  ViewController.m
//  网易新闻
//
//  Created by helangxin on 16/4/11.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDHeadLineController.h"
#import "JDHeadLineModel.h"
#import "JDLoopView.h"

@interface JDHeadLineController ()

@property (nonatomic, strong)  NSArray *headlines;
@end

@implementation JDHeadLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [JDHeadLineModel HeadLineSuccess:^(NSArray *headlines)
      {
          NSArray *imgs=[headlines valueForKeyPath:@"imgsrc"];
          NSArray*titles=[headlines valueForKeyPath:@"title"];
          //根据回调获得数组模型，创建轮播器
          JDLoopView *loopView=[[JDLoopView alloc]initWithUrls:imgs title:titles];
          loopView.frame=self.view.bounds;
          [self.view addSubview:loopView];
     } andFailed:^(NSError *error) {
           NSLog(@"error====%@",error);
     }];    
}

@end
