//
//  JDNewsViewController.m
//  网易新闻
//
//  Created by helangxin on 16/4/15.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDNewsViewController.h"
#import "JDNewsViewController.h"
#import "JDNewsModel.h"
#import "JDNewsCell.h"

@interface JDNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *news;

@end

@implementation JDNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [JDNewsModel NewsSuccess:^(NSArray *news)
     {
         self.news=news;
         [self.tableView reloadData];
     } andFailed:^(NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.news.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取模型
    JDNewsModel*news=self.news[indexPath.row];
    //根据标识符返回不同的cell
    JDNewsCell*cell=[tableView dequeueReusableCellWithIdentifier:[JDNewsCell identifiy:news]];
    cell.newsModel=news;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取模型
    JDNewsModel*news=self.news[indexPath.row];
    return [JDNewsCell cellHeight:news];
}
@end
