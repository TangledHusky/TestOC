//
//  SelectColorEasyView.h
//  TestOC
//
//  Created by 李亚军 on 2017/2/8.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectColorEasyViewDelegate <NSObject>

-(void)SelectColorEasyViewDidSelectColor:(UIColor *)color;

@end

@interface SelectColorEasyView : UIView

@property (nonatomic,weak) id<SelectColorEasyViewDelegate>  delegate;

@end
