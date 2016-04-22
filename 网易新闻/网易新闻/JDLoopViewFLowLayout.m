//
//  JDLoopViewFLowLayout.m
//  网易新闻
//
//  Created by helangxin on 16/4/14.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDLoopViewFLowLayout.h"

@implementation JDLoopViewFLowLayout


//系统准备布局的时候调用
-(void)prepareLayout
{
    [super prepareLayout];
   // NSLog(@"%@",NSStringFromCGSize(self.collectionView.bounds.size));
    
    //self.itemSize=self.collectionView.size;
    self.itemSize=self.collectionView.bounds.size;
    
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    self.minimumLineSpacing=0;
    self.minimumInteritemSpacing=0;
}
@end
