//
//  JDChannelModel.m
//  网易新闻
//
//  Created by helangxin on 16/4/16.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDChannelModel.h"

@implementation JDChannelModel

+ (instancetype)channelWithDict:(NSDictionary *)dict
{
    id obj=[[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {}
+(NSArray*)channel
{
   NSString*path= [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
   NSString*keyRoot= dict.keyEnumerator.nextObject;
    
   NSArray*arr = dict[keyRoot];
    
    NSMutableArray *desArr=[NSMutableArray array];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [desArr addObject: [JDChannelModel channelWithDict:dict]];
    }];
   
    
    return desArr;
    
    
}



@end
