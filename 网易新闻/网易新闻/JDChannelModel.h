//
//  JDChannelModel.h
//  网易新闻
//
//  Created by helangxin on 16/4/16.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDChannelModel : NSObject
/**
 *  频道名称
 */
@property (nonatomic, copy) NSString *tname;
/**
 *  频道id
 */
@property (nonatomic, copy) NSString *tid;
//返回所有的channel数组
+(NSArray*)channel;

+ (instancetype)channelWithDict:(NSDictionary *)dict;

@end
