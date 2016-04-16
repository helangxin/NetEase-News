//
//  JDLoopViewCell.m
//  网易新闻
//
//  Created by helangxin on 16/4/14.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDLoopViewCell.h"
#import "UIImageView+WebCache.h"


@interface JDLoopViewCell ()


@property (nonatomic, weak) UIImageView *iconView;
@end

@implementation JDLoopViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIImageView *iconView=[[UIImageView alloc]init];
        
        [self addSubview:iconView];
        self.iconView=iconView;
    };
    return self;
}

-(void)setURLs:(NSURL *)URLs
{
    _URLs=URLs;
    [self.iconView sd_setImageWithURL:URLs];
    NSLog(@"%s", __FUNCTION__);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView.frame=self.bounds;
}

@end
