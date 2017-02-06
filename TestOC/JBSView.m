//
//  JBSView.m
//  TestOC
//
//  Created by 李亚军 on 2016/12/27.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "JBSView.h"

@implementation JBSView
{
    UIColor *_startColor;
    UIColor *_endColor;
    
}


-(instancetype)initWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    self = [super initWithFrame:frame];
    if (self) {
        _startColor = startColor;
        _endColor = endColor;
        
    }
    
    return self;
}



-(void)drawRect:(CGRect)rect{

    
}

@end
