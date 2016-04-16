//
//  HeadLineModel.m
//  网易新闻
//
//  Created by helangxin on 16/4/12.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDHeadLineModel.h"
#import "JDNewsTool.h"

@implementation JDHeadLineModel
//字典转换成模型
+ (instancetype)headWithDict:(NSDictionary *)dict
{
    id obj=[[self alloc]init];
    
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
   // return [[self alloc] initWithDict:dict];
  
}

/**
 *  一开始是NSArrary但是这个是异步加载，不能有返回值，所以当调用方调用时，需要用block返回给调用方
    所以才创建block，创建成功回调和失败回调
 *
 */
+(void)HeadLineSuccess:(void(^)(NSArray*))finish andFailed:(void(^)(NSError* ))failed
{
    // //    http://c.m.163.com/nc/ad/headline/0-4.html
    
    //拼接字符串
    [[JDNewsTool shareManager]GET:@"headline/0-4.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
       
        
         NSLog(@"%@--",responseObject);
        //获得字典的第一个Key
        NSString *rootKey=responseObject.keyEnumerator.nextObject;
        //获取数组
        NSArray *HeadLineArr=responseObject[rootKey];
        
        NSMutableArray *Arr=[NSMutableArray arrayWithCapacity:HeadLineArr.count];
        //遍历数组
        [HeadLineArr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [ Arr addObject:[JDHeadLineModel headWithDict:dict]];
        }];
        //NSLog(@"%@",HeadLineArr);
        
        
        //传值
        finish(Arr.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"error====%@",error);
        if (failed)
        {
            failed(error);
        }
        
    }];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
