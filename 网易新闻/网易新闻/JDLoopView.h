//
//  JDLoopView.h
//  网易新闻
//
//  Created by helangxin on 16/4/14.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDLoopView : UIView


@property (nonatomic, assign) NSTimer*timeInterval ;


@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, assign) BOOL *enTimer;

//根据URL和title初始化轮播器
-(instancetype)initWithUrls:(NSArray<NSString*>*)URLs title:(NSArray<NSString*>*)title;

@end
