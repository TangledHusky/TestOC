//
//  XibShow.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/23.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "XibShow.h"

@implementation XibShow

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"initWithCoder");
        [self initViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
        [self initViews];
    }
    return self;
}

-(void)awakeFromNib{
    NSLog(@"awakeFromNib");
    [super awakeFromNib];
    [self initViews];
    
    
}


-(void)initViews{
     [[NSBundle mainBundle] loadNibNamed:@"XibShow" owner:self options:nil];
    [self addSubview:self.container];
    self.container.frame = self.bounds;
    
    
    
}

@end
