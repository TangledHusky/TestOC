//
//  LandScreenViewController.h
//  TestOC
//
//  Created by 李亚军 on 2017/1/6.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,NewPageType){
    NewPageTypePush,
    NewPageTypePresent
    
};


@interface LandScreenViewController : UIViewController
@property (nonatomic,assign) NewPageType  newPageType;

@end
