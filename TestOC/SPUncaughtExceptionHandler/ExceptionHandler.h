//
//  UncaughtExceptionHandler.h
//  TestOC
//
//  Created by liyajun on 2017/9/26.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const UncaughtExceptionHandlerSignalKey;
extern NSString *const SingalExceptionHandlerAddressesKey;
extern NSString *const ExceptionHandlerAddressesKey;

@interface ExceptionHandler : NSObject
+ (void)installExceptionHandler;
+ (NSArray *)backtrace;
