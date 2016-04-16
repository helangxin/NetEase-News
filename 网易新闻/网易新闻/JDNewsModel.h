//
//  JDNewsModel.h
//  网易新闻
//
//  Created by helangxin on 16/4/15.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDNewsModel : NSObject

/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  新闻图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  跟帖数
 */
@property (nonatomic, copy) NSString *replyCount;

//多图cell
@property (nonatomic, strong) NSArray *imgextra;

//大图
@property (nonatomic, assign) BOOL imgType;


+ (instancetype)newsWithDict:(NSDictionary *)dict;

//创建成功和失败的回调方法
+(void)NewsSuccess:(void(^)(NSArray*))finish andFailed:(void(^)(NSError*))failed;
@end
