//
//  JDNewsCell.m
//  网易新闻
//
//  Created by helangxin on 16/4/15.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDNewsCell.h"
#import "UIButton+WebCache.h"

@implementation JDNewsCell


//给模型赋值
-(void)setNewsModel:(JDNewsModel *)newsModel
{
    _newsModel=newsModel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] forState:UIControlStateNormal];
    self.titleView.text=newsModel.title;
    self.replyCountView.text=newsModel.replyCount;
    self.detailView.text=newsModel.digest;
}

@end
