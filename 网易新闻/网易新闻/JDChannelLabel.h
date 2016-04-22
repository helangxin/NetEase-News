//
//  JDlable.h
//  网易新闻
//
//  Created by helangxin on 16/4/16.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDChannelLabel : UILabel


+(instancetype)labelWithText:(NSString*)text;


@property (nonatomic, assign) CGFloat scale;
//选中时执行的block
@property (nonatomic, copy) void (^didSelect)();

@end
