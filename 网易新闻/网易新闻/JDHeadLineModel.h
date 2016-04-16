//
//  HeadLineModel.h
//  网易新闻
//
//  Created by helangxin on 16/4/12.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDHeadLineModel : NSObject


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgsrc;



+ (instancetype)headWithDict:(NSDictionary *)dict;


//创建成功和失败的回调方法
+(void)HeadLineSuccess:(void(^)(NSArray*))finish andFailed:(void(^)(NSError*))failed;


@end
