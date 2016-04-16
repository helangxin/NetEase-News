//
//  JDHomeController.m
//  网易新闻
//
//  Created by helangxin on 16/4/16.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDHomeController.h"
#import "JDChannelModel.h"

@interface JDHomeController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;

@property (nonatomic, strong) NSArray *channelModel;

@end

@implementation JDHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"首页";
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.channelModel;
}

#pragma mark ---lanjiaz
-(NSArray *)channelModel
{
    if (!_channelModel) {
        _channelModel=[JDChannelModel channel];
        
    }
    return _channelModel;
}
@end
