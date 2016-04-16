//
//  JDNewsTool.h
//  网易新闻
//
//  Created by helangxin on 16/4/12.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface JDNewsTool : AFHTTPSessionManager

+(instancetype)shareManager;
@end
