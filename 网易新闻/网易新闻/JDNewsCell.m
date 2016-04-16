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
   self.replyCountView.text=[NSString stringWithFormat:@"%@人跟帖",newsModel.replyCount.description];
    self.detailView.text=newsModel.digest;
    
    /**
     *  三张图片的第一张用imagesrc的属性赋值，后面两张返回的是数组需要遍历之后再重新赋值,多图的cell的模型遍历
     */
    [newsModel.imgextra enumerateObjectsUsingBlock:^(NSDictionary*imageDict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *imageBtn=self.imageBtn[idx];
        
        NSString*imageUrlStr=imageDict[@"imgsrc"];
        
        [imageBtn sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] forState:UIControlStateNormal];
    }];
}

+(NSString*)identifiy:(JDNewsModel*)news
{
    if (news.imgType)
    {
        return @"BigImageCell";
    }
    else if (news.imgextra)
    {
        return @"numberCell";
    }
    else
    {
        return @"news";
    }
}

+(CGFloat)cellHeight:(JDNewsModel*)news{
    if (news.imgType)
    {
        return 170;
    }
    else if (news.imgextra)
    {
        return 120;
    }
    else{
        return 80;
    }
}
@end
