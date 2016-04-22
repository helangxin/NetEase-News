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

#pragma mark ---重写set
-(void)setTid:(NSString *)tid
{
    _tid=[tid copy];
    
    self.URLstring=[NSString stringWithFormat:@"/nc/article/headline/%@/0-20.html",tid];
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
        
        [desArr addObject: [JDChannelModel channelWithDict:obj]];
    }];
    
    //升序排列
    desArr=[desArr sortedArrayUsingComparator:^NSComparisonResult(JDChannelModel* obj1,JDChannelModel* obj2) {
        return [obj1.tid compare:obj2.tid];
    }].copy;
    //Incompatible pointer types assigning to 'NSMutableArray *' from 'NSArray *'
    return desArr;    
}



@end
