//
//  JDNewsCell.h
//  网易新闻
//
//  Created by helangxin on 16/4/15.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDNewsModel.h"


@interface JDNewsCell : UITableViewCell
//头像
@property (nonatomic, weak) IBOutlet UIButton *iconView;
//标题
@property (nonatomic, weak) IBOutlet UILabel *titleView;
//描述
@property (nonatomic, weak) IBOutlet UILabel *detailView;

//跟帖数
@property (nonatomic, weak) IBOutlet UILabel *replyCountView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imageBtn;


@property (nonatomic, strong) JDNewsModel *newsModel;

//根据模型标识返回不同类型的cell
+(NSString*)identifiy:(JDNewsModel*)news;

//设置行高
+(CGFloat)cellHeight:(JDNewsModel*)news;

@end
