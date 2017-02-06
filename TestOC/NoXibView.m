//
//  NoXibView.m
//  TestOC
//
//  Created by 李亚军 on 2017/1/23.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "NoXibView.h"

@implementation NoXibView{
    UILabel *lbl;
    UIButton *btn;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"initWithCoder   noxib");
        [self initViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame   noxib");
        [self initViews];
    }
    return self;
}

-(void)awakeFromNib{
    NSLog(@"awakeFromNib  noxib");
    [super awakeFromNib];
    [self initViews];
    
    
}


-(void)initViews{
    self.backgroundColor = [UIColor yellowColor];
    lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth/2, 20)];
    lbl.backgroundColor = [UIColor redColor];
    [self addSubview:lbl];

    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, KScreenWidth/2, 30)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"点击变长" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];

    
}

-(void)clickBtn{
    lbl.text = [NSString stringWithFormat:@"%d",arc4random_uniform(100)] ;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"layoutSubviews---%@",lbl.text);
    [UIView animateWithDuration:0.2 animations:^{
        lbl.frame = CGRectMake(0, 0, arc4random_uniform(300), 20);
    }];
    
}

@end
