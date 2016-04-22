//
//  JDNewsModel.m
//  网易新闻
//
//  Created by helangxin on 16/4/15.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDNewsModel.h"
#import "JDNewsTool.h"

@implementation JDNewsModel

-(void)setDocid:(NSInteger)docid
{
    _docid=docid;
    _deatilURLString=[NSString stringWithFormat:@"//c.3g.163.com/nc/article/%ld/full.html",(long)docid];
}
//字典转换成模型
+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    id obj=[[self alloc]init];
    
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
        
}
/**
 *  一开始是NSArrary但是这个是异步加载，网络上不能有返回值，所以当调用方调用时，需要用block返回给调用方
 所以才创建block，创建成功回调和失败回调
 *
 */
+(void)loadData:(NSString*)url NewsSuccess:(void(^)(NSArray*))finish andFailed:(void(^)(NSError* ))failed
{
    //拼接字符串
    [[JDNewsTool shareManager]GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject)
     {
        //NSLog(@"%@--",responseObject);
        //获得字典的第一个Key
        NSString *rootKey=responseObject.keyEnumerator.nextObject;
        //获取数组
        NSArray *HeadLineArr=responseObject[rootKey];
        
        NSMutableArray *Arr=[NSMutableArray arrayWithCapacity:HeadLineArr.count];
        //遍历数组
        [HeadLineArr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [ Arr addObject:[JDNewsModel newsWithDict:dict]];
        }];
        //NSLog(@"%@",HeadLineArr);

        //传值
        finish(Arr.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
        // NSLog(@"error====%@",error);
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
