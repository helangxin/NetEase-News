//
//  JDHomeController.m
//  网易新闻
//
//  Created by helangxin on 16/4/16.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDHomeController.h"
#import "JDChannelModel.h"
#import "JDChannelLabel.h"
#import "JDHomeViewCell.h"
#import "JDNewsViewController.h"
#import "JDNewsModel.h"

@interface JDHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
//设置布局属性
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayout;

@property (nonatomic, strong) NSArray *channelModel;

//控制器缓存
@property (nonatomic, strong) NSMutableDictionary *controllerCache;

@property (nonatomic, assign) NSInteger currentIndex;



@end

@implementation JDHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"首页";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    self.collectView.backgroundColor=[UIColor whiteColor];
    //self.scrollView.backgroundColor=[UIColor redColor];
    self.collectView.dataSource=self;
    
    self.collectView.delegate=self;
    
    self.scrollView.delegate=self;
    
    [self addlabel];
    //[self.scrollView addSubview:<#(nonnull UIView *)#>]
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    //[]
//}

/**
 *  当控制器的view布局子控件时调用,只要调用该方法,控制器view的frame就应经设置好尺寸
 */
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setupFlowLayout];
}

#pragma mark ---设置布局属性
-(void)setupFlowLayout
{
//    NSLog(@"%@",NSStringFromCGRect(self.collectView.bounds));
    //因为collectionview的大小设置为平铺的
    self.flowlayout.itemSize=self.collectView.bounds.size;
    self.flowlayout.minimumLineSpacing=0;
    self.flowlayout.minimumInteritemSpacing=0;
    self.collectView.showsHorizontalScrollIndicator=NO;
    //self.collectView.showsVerticalScrollIndicator=NO;
   // NSLog(@"%@",NSStringFromCGSize(self.collectView.bounds.size));
     self.collectView.pagingEnabled = YES;
    //水平滚动
    self.flowlayout.scrollDirection=   UICollectionViewScrollDirectionHorizontal;

}
#pragma mark ---获得当前索引
//一滑动的时候就监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   // NSLog(@"%s", __FUNCTION__);
    //获得当前的索引
    JDChannelLabel *currentLabel=self.scrollView.subviews[self.currentIndex];
    
    //获得可视的item
    NSArray*indexPaths= [self.collectView  indexPathsForVisibleItems];
    
    //获得下一个索引
    JDChannelLabel *nextLabel=nil;
    //遍历
    for (NSIndexPath *indexPath in indexPaths )
    {
        if (indexPath.item!=self.currentIndex)
        {   //取出下一个标签
            nextLabel=self.scrollView.subviews[indexPath.item];
            break;
        }
    }
    if (nextLabel==nil)
    {
        return;
    }
    //计算下一个标签的缩放比例  偏移量有可能是负数
    CGFloat nextlabelSacle=ABS(self.collectView.contentOffset.x/self.collectView.frame.size.width-self.currentIndex);
    //计算当前标签的缩放比例
    CGFloat currentSacle=1-nextlabelSacle;
    currentLabel.scale=currentSacle;
    nextLabel.scale=nextlabelSacle;
    
    //NSLog(@"从%@-----到%@",currentLabel.text,nextLabel.text);
    
    //设置缩放比例
    
    self.currentIndex=self.collectView.contentOffset.x/scrollView.frame.size.width;

    
}
//慢慢减速停止时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算当前的索引
    self.currentIndex=self.collectView.contentOffset.x/scrollView.frame.size.width;
    //NSLog(@" self.currentIndex===%zd",self.currentIndex);
}
//添加标签
-(void)addlabel
{
    self.automaticallyAdjustsScrollViewInsets=NO;
   NSInteger index =0;
    CGFloat labelX=8;
    CGFloat labelH=self.scrollView.frame.size.height;
    
        //遍历模型
    for (JDChannelModel *channel in self.channelModel)
    {
        JDChannelLabel *currentlabel=[JDChannelLabel labelWithText:channel.tname ];
        
       currentlabel.tag=index++;
        __weak  typeof(self)weakSelf=self;
        __weak typeof(currentlabel)weakLabel=currentlabel;
        //添加点击事件
       [currentlabel setDidSelect:^{
           //NSLog(@"hehe");
           //设置未选中时缩放比例
           JDChannelLabel*previousLabel=self.scrollView.subviews[self.currentIndex];
           previousLabel.scale=0;
           
           //当前缩放比例为1
           weakLabel.scale =1;
           
           // 重新复制currentIndex
           weakSelf.currentIndex=weakLabel.tag;
           
           //滑动指定的位置
           [weakSelf.collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:weakLabel.tag inSection:0] atScrollPosition:  UICollectionViewScrollPositionLeft  animated:YES];
          // NSLog(@"%@",weakLabel.text);
           
           // 计算scrollView  x方向要偏移的值
           CGFloat offset=weakLabel.center.x -weakSelf.scrollView.frame.size.width*0.5;
           // 计算最大滚动范围
           CGFloat maxOffset=weakSelf.scrollView.contentSize.width-weakSelf.scrollView.frame.size.width;
           
           /**
            *  判断offset和maxoffset
            *
            */
           if (offset<=0)
           {
               offset=0;
           }
           else if (offset>maxOffset)

           {
               offset=maxOffset;
           }
           //设置偏移量
           [weakSelf.scrollView setContentOffset:CGPointMake(offset, 0)];

       }];
        
        
        //添加选中标签的偏移量
        currentlabel.frame=CGRectMake(labelX, 0, currentlabel.frame.size.width, labelH);
        //NSLog(@"%@",NSStringFromCGRect(label.frame));
        [self.scrollView addSubview:currentlabel];
        labelX+=currentlabel.frame.size.width;
    }
    
     // 设置x和y值
    self.scrollView.contentSize=CGSizeMake(labelX, 0);
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    
    //默认头条选中
    JDChannelLabel *label=self.scrollView.subviews[self.currentIndex];
    label.scale=1;
    
}

#pragma mark ---懒加载
-(NSArray *)channelModel
{
    if (!_channelModel) {
        _channelModel=[JDChannelModel channel];
    }
    return _channelModel;
}


#pragma mark---实现数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.channelModel.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   // NSLog(@"%s", __FUNCTION__);
    JDHomeViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"hehecell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    //获取数据模型
    JDChannelModel *channel=self.channelModel[indexPath.item];
    
    //根据新闻模型获得新闻控制器
    JDNewsViewController *newsVC=[self newsVC:channel];
    cell.newsVC=newsVC;
    //cell.URLstring =channel.URLstring;
    
    
    /**
     *    // 添加子视图控制器，注意这句话一定要有，否则会打断响应者链条
     */
    if (![self.childViewControllers containsObject:cell.newsVC])
    {
        [self addChildViewController:cell.newsVC];
    }
    
    return cell;
}

#pragma mark ---创建控制器缓存池
//根据新闻模型获得新闻控制器
-(JDNewsViewController*)newsVC:(JDChannelModel*)channelModel
{   //去缓存池找控制器
    JDNewsViewController*newsVC=self.controllerCache[channelModel.tid];
    if (newsVC==nil)
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"news" bundle:nil];
        
        newsVC= sb.instantiateInitialViewController;
        
        //将频道的url 传给控制器
        newsVC.URLString=channelModel.URLstring;
        
        //将控制器添加到缓存池
        [self.controllerCache setObject:newsVC forKey:channelModel.tid];
    }
    return newsVC;
    
}


@end
