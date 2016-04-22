//
//  JDHomeViewCell.m
//  网易新闻
//
//  Created by helangxin on 16/4/16.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDHomeViewCell.h"
#import "JDNewsViewController.h"

@interface JDHomeViewCell ()

//@property (nonatomic, strong) JDNewsViewController * newsVC;




@end

@implementation JDHomeViewCell
//
//- (void)awakeFromNib
//{
//    NSLog(@"%s", __FUNCTION__);
//    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"news" bundle:nil];
//    
//    self.newsVC= sb.instantiateInitialViewController;
//    
//    [self addSubview:self.newsVC.view];
//  
//}
//接收外界传入的控制器
-(void)setNewsVC:(JDNewsViewController *)newsVC
{
    _newsVC=newsVC;
    [self addSubview:newsVC.view];
}


-(void)setURLstring:(NSString *)URLstring
{
    URLstring=URLstring.copy;
    self.newsVC.URLString=URLstring;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.newsVC.view.frame=self.bounds;
}


@end
