//
//  JDlable.m
//  网易新闻
//
//  Created by helangxin on 16/4/16.
//  Copyright © 2016年 helangxin. All rights reserved.
//

#import "JDChannelLabel.h"
#define maxSacle 18
#define minSacle 14

@implementation JDChannelLabel



//返回标签
+(instancetype)labelWithText:(NSString*)text
{
    JDChannelLabel *label=[[JDChannelLabel alloc]init];
    label.text=text;
    
    label.font=[UIFont systemFontOfSize:18];
    //标签的文字和尺寸自适应
    [label sizeToFit];
    //label.textColor=[UIColor blackColor];
    
    label.font=[UIFont systemFontOfSize:14];
    
    /**
     *  设置label可以交互
     */
    label.userInteractionEnabled=YES;
    
    return label;

}
#pragma mark ---设置缩放比例
-(void)setScale:(CGFloat)scale
{
    _scale=scale;
    
    //设置最大比例
    CGFloat max=(CGFloat)(maxSacle -minSacle)/(minSacle);
    
    //真实缩放比例
    CGFloat realscale=(scale *max+1);
    
    self.transform=CGAffineTransformMakeScale(realscale, realscale);
    
    self.textColor=[UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{       NSLog(@"%@", self.text);
    
    if (self.didSelect)
    {
        self.didSelect();
    }
}
@end
