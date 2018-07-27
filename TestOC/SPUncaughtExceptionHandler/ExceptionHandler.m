//
//  UncaughtExceptionHandler.m
//  TestOC
//
//  Created by liyajun on 2017/9/26.
//  Copyright © 2017年 zyyj. All rights reserved.
//

#import "ExceptionHandler.h"




NSString *const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString *const SingalExceptionHandlerAddressesKey = @"SingalExceptionHandlerAddressesKey";
NSString *const ExceptionHandlerAddressesKey = @"ExceptionHandlerAddressesKey";

const int32_t _uncaughtExceptionMaximum = 20;

// 系统信号截获处理方法
void signalHandler(int signal);

// 异常截获处理方法
void exceptionHandler(NSException *exception);

void signalHandler(int signal)
{
    volatile int32_t _uncaughtExceptionCount = 0;
    int32_t exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);
    
    // 如果太多不用处理
    if (exceptionCount > _uncaughtExceptionMaximum) {
        return;
    }
    
    // 获取信息
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];
    NSArray *callStack = [ExceptionHandler backtrace];
    [userInfo  setObject:callStack  forKey:SingalExceptionHandlerAddressesKey];
    
    // 现在就可以保存信息到本地［］
    
}

void exceptionHandler(NSException *exception)
{
    volatile int32_t _uncaughtExceptionCount = 0;
    int32_t exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);
    
    // 如果太多不用处理
    if (exceptionCount > _uncaughtExceptionMaximum) {
        return;
    }
    
    NSArray *callStack = [ExceptionHandler backtrace];
    NSMutableDictionary *userInfo =[NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:ExceptionHandlerAddressesKey];
    NSLog(@"Exception Invoked: %@", userInfo);
    
    // 现在就可以保存信息到本地［］
    [[NSUserDefaults standardUserDefaults] setInteger:@123 forKey:@"test123"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@implementation ExceptionHandler
//获取调用堆栈
+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack,frames);
    
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i=0;i<frames;i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}


// 注册崩溃拦截
+ (void)installExceptionHandler
{
    NSSetUncaughtExceptionHandler(&exceptionHandler);
    signal(SIGHUP, signalHandler);
    signal(SIGINT, signalHandler);
    signal(SIGQUIT, signalHandler);
    signal(SIGABRT, signalHandler);
    signal(SIGILL, signalHandler);
    signal(SIGSEGV, signalHandler);
    signal(SIGFPE, signalHandler);
    signal(SIGBUS, signalHandler);
    signal(SIGPIPE, signalHandler);
}
@end
