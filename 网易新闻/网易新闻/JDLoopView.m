//
//  JDLoopView.m
//  网易新闻
//
//  Created by helangxin on 16/4/14.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDLoopView.h"
#import "JDHeadLineModel.h"
#import "JDLoopViewFLowLayout.h"
#import "JDLoopViewCell.h"
@interface JDLoopView ()<UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *URLs;

@property (nonatomic, strong) UICollectionView *colletionView;
//标题
@property (nonatomic, strong) NSArray *title;

@property (nonatomic, strong) UIPageControl *PageControl ;

@property (nonatomic, weak) UILabel *titlelabel;


@end

@implementation JDLoopView

-(instancetype)initWithUrls:(NSArray<NSString*>*)URLs title:(NSArray<NSString*>*)title
{
    if (self=[super init])
    {
        //记录属性
        self.title=title;
        self.URLs=URLs;
        
        self.titlelabel.text=self.title[0];
        //设置页数
        self.PageControl.numberOfPages=self.URLs.count;
        
        //主队列的主线程，当执行完主线程之后，空闲才执行，当执行完数据源方法后，执行滚动到指定位置
        //滚动到指定位置 ，知道有多少个item
       // dispatch_async(dispatch_get_main_queue(), ^{
           // if (self.URLs.count>1)
            //{       // 滚动到数组个数指定的位置
                  //[self.colletionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.URLs.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//                //添加定时器
//                [self addTimer];
            //}
        //});
       
    }
    return self;
}


#pragma mark ---添加子控件
-(instancetype)initWithFrame:(CGRect)frame

{
    NSLog(@"%s", __FUNCTION__);
    if (self=[super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder ]) {
        
        [self setup];
    }
    return self;
}
//布局属性
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleH=30.0f;
    CGRect frame=self.bounds;
    frame.size.height=frame.size.height-titleH;
    self.colletionView.frame=frame;
    
    //设置pagecontrol
    
    CGFloat marginX=20;
    CGFloat pageW=40;
    CGFloat pageX=frame.size.width-marginX-pageW;
    CGFloat pageH=titleH;
    CGFloat pageY=self.colletionView.frame.size.height;
    //self.PageControl.tintColor=[UIColor redColor];
    self.PageControl.frame=CGRectMake(pageX, pageY, pageW, pageH);
    NSLog(@"self.PageControl.frame===%@",NSStringFromCGRect(self.PageControl.frame));
    
    //设置titlelabe
    CGFloat titleX=marginX*0.5;
    CGFloat titleY=pageY;
    CGFloat titleW=pageX-titleX;     //pageW-marginX;
    self.titlelabel.frame=CGRectMake(titleX, titleY, titleW, titleH);
}


#pragma mark ---添加定时器

-(void)addTimer
{
    if (self.timer) {
        return;
    }
    if (!self.enTimer) {
        return;
    }
    //创建定时器
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:10 target:self.timeInterval selector:@selector(update) userInfo:nil repeats:YES];
    
    //将定时器添加到运行环
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
}


#pragma mark----移除定时器

-(void)removeTimer
{
    [self.timer invalidate];
    self.timer=nil;
}


#pragma mark -----定时器回调
-(void)update
{
    NSLog(@"%s", __FUNCTION__);
    
    //计算分页
    
    NSInteger page=(CGFloat)self.colletionView.contentOffset.x /self.colletionView.frame.size.width;
    
    //设置偏移量
    CGFloat offsetX=(page+1)*self.colletionView.frame.size.width;
    
    [self.colletionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark---添加子控件
-(void)setup
{
    NSLog(@"%s", __FUNCTION__);
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[JDLoopViewFLowLayout alloc]init]];
    //为什么要自定义FLowLayout？？
    collectionView.backgroundColor=[UIColor whiteColor];
    [collectionView registerClass:[JDLoopViewCell class] forCellWithReuseIdentifier:@"JD"];
    collectionView.dataSource=self;
    [self addSubview:collectionView];
    self.colletionView=collectionView;
    
    //创建标题
    UILabel *titlelabel=[[UILabel alloc]init];
    titlelabel.textColor=[UIColor redColor];
    titlelabel.font=[UIFont systemFontOfSize:16];
    
    
    [self addSubview:titlelabel];
    self.titlelabel=titlelabel;
    
    
    UIPageControl*PageControl=[[UIPageControl alloc]init];
    PageControl.numberOfPages=self.URLs.count;
    
    // 设置当前显示页的颜色
    PageControl.currentPageIndicatorTintColor = [UIColor redColor];
    PageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    [self addSubview:PageControl];
    self.PageControl=PageControl;
}

#pragma mark ---实现数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.URLs.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    JDLoopViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"JD" forIndexPath:indexPath];
    // 传递url
    cell.URLs = [NSURL URLWithString:self.URLs[indexPath.item % self.URLs.count]];
    cell.backgroundColor=[UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    return cell;
}

/**
 *  手动拖拽即将停止时调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前的页号
    NSInteger page=scrollView.contentOffset.x/scrollView.frame.size.width;
    
    //如果是第1页和最后一页
    if (page==0 || page==[self.colletionView numberOfSections]-1)
    {
        CGFloat offsetX=self.URLs.count-((page==0)?0:1) *scrollView.frame.size.width;
        self.colletionView.contentOffset=CGPointMake(offsetX, 0);
    }
    NSLog(@"%zd",page);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取当前的页号
    NSInteger page=scrollView.contentOffset.x/scrollView.frame.size.width+0.5;
    self.PageControl.currentPage=page%self.URLs.count;
    self.titlelabel.text=self.title[page%self.title.count];
    
}
/**
 *  自动滚动结束时调用(手动拖拽不会触发该代理方法)
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

@end
