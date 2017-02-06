//
//  WZXNetworking.h
//  MyHome
//
//  Created by DHSoft on 16/8/29.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define WZXLog(w, ... ) NSLog( @"[%@ in line %d] ===============>%@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__ , [NSString stringWithFormat:(w), ##__VA_ARGS__] )

#else
#define WZXLog(w, ... )
#endif


typedef NS_ENUM(NSUInteger, WZXResponseType){
    kWZXResponseTypeJSON = 1, // 默认
    kWZXResponseTypeXML  = 2, // xml
    // 特殊情况，一转换服务器就无法识别的，默认会尝试装换成JSON，若识别则需要自己去转换
    kWZXResponseTypeData = 3
    
};


typedef NS_ENUM(NSUInteger, WZXRequestType){
    kWZXRequestTypeJSON = 1, // 默认
    kWZXRequestTypePlainText = 2 // text/html
};

typedef NS_ENUM(NSInteger, WZXNetworkStatus) {
    kWZXNetworkStatusUnknown           = -1,// 未知网络
    kWZXNetworkStatusNotReachable      = 0, // 没网络
    kWZXNetworkStatusReachableViaWWAN  = 1, // 2G，3G，4G
    kWZXNetworkStatusReachableViaWiFi  = 2  // WIFI
    
};


@class NSURLSessionTask;
// 所有接口返回的类型都是基于NSURLSessionTask，若要接收返回值处理，转换成对应的子类类型
typedef NSURLSessionTask WZXURLSessionTask;
typedef void(^WZXResponseSuccess)(id response);
typedef void(^WZXResponseError)(NSError *error);

/**
 *  基于AFNetWorking的网络层封装类
 */
@interface WZXNetworking : NSObject

/**
 *  用于指定网络请求接口的域名,
 *  通常在AppDelegate中启动时就设置一次就可以了，如果接口有来源于多个服务器，可以调用更新
 *
 *  @param baseUrl 网络请求的域名
 */
+ (void)APPUpDateBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;

/**
 *  请求超时时间，默认60秒
 *
 *  @param timeout 超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout;

/**
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期，最好打开 ,默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/**
 *  获取缓存大小
 *
 *  @return 缓存大小
 */
+ (unsigned long long)totalCacheSize;


/**
 *  清除缓存
 */
+ (void)clearCaches;


/**
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST,请在全局配置一下
 *
 *  @param requestType                   请求格式，默认为JSON
 *  @param responseType                  响应格式，默认为JSON
 *  @param shouldAutoEncode              默认为NO，是否自动encodeurl
 *  @param shouldCallbackOnCancelRequest 当取消请求时，是否要回调，默认为YES
 */
+ (void)comfigRequestType:(WZXRequestType)requestType responseType:(WZXResponseType)responseType shouldAutoEncodeUrl:(BOOL)shouldAutoEncode callbackOnCancelRequsest:(BOOL) shouldCallbackOnCancelRequest;

/**
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将于服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *
 *  取消所有请求
 */
+ (void)cancelAllRequest;


/**
 *  取消某个网络请求，如果是要取消某个请求，最好是引用接口所返回来的WXZURLSessionTask对象
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供一种方法来实现取消某个请求
 *
 *  @param url URL,可以是绝对URL，也可以是不包括baseurl
 */
+ (void)cancelRequestWithURL:(NSString *)url;

/**
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中可取消请求的API
 */

+ (WZXURLSessionTask *)getWithUrl:(NSString *)url success:(WZXResponseSuccess)success fail:(WZXResponseError)fail;

/**
 *  POST请求接口
 *
 *  @param url     接口路径
 *  @param params  接口所需的参数
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可能取消请求的API
 */
+ (WZXURLSessionTask *)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(WZXResponseSuccess)success fail:(WZXResponseError)fail;


/**
 *  图片上传调用方法
 *
 *  @param url                请求的URL地址
 *  @param params             额外的参数
 *  @param arrImage           图片集合数组
 *  @param compressionQuality 压缩比例
 */
+ (void)updataVideoWithUrl:(NSString *)url withParams:(NSDictionary *)params withImage:(NSArray *)arrImage withCompressionQuality:(CGFloat)compressionQuality success:(WZXResponseSuccess)success fail:(WZXResponseError)fail;


@end
