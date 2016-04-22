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
#import "JDDetailNewsController.h"

@interface JDNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *news;

@end

@implementation JDNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   }


-(void)setURLString:(NSString *)URLString
{
    _URLString=URLString.copy;
    
    //打印加载不同的新闻模型cell的重用
    NSLog(@"%@", URLString);
    
    [JDNewsModel loadData:URLString NewsSuccess:^(NSArray *news) {
    self.news=news;
    [self.tableView reloadData];
} andFailed:^(NSError *error)
    {
    
}];
//    [JDNewsModel NewsSuccess:^(NSArray *news)
//     {
//     
//     } andFailed:^(NSError *error)
//    {
//         
//     }];

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *desVC=[[JDDetailNewsController alloc]init];
    [self.navigationController pushViewController:desVC animated:YES];
}
@end
