//
//  JDNewsTool.m
//  网易新闻
//
//  Created by helangxin on 16/4/12.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDNewsTool.h"

//创建单例
@implementation JDNewsTool

+(instancetype)shareManager
{
    static JDNewsTool  *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url=[NSURL URLWithString:@"http://c.m.163.com/nc/ad/"];
        
        instance=[[self alloc]initWithBaseURL:url];
        
        instance.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
        
    });
    return instance;
    
}
@end
