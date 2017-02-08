//
//  SelectColorPickerView.h
//  boxasst_iosphone
//
//  Created by admin on 16/10/26.
//  Copyright © 2016年 taixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectColorPickerViewDelegate <NSObject>

- (void)getCurrentColor:(UIColor *)color;

@end

@interface SelectColorPickerView : UIView

@property (nonatomic, assign)id<SelectColorPickerViewDelegate>delegate;

@end
