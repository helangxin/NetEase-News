//
//  JDHomeViewCell.h
//  网易新闻
//
//  Created by helangxin on 16/4/16.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDNewsViewController.h"

@interface JDHomeViewCell : UICollectionViewCell

//加载不同的新闻
//@property (nonatomic, copy) NSString *URLstring;

//接收外界传入的控制器
@property (nonatomic, strong) JDNewsViewController *newsVC;
@end
