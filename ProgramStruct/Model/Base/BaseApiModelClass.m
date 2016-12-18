//
//  BaseApiModelClass.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/14.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "BaseApiModelClass.h"
#import "NSObject+Network.h"
#import "JsonDataCache.h"
@implementation BaseApiModelClass

+(NSString*)constructCacheKeyByUrl:(NSString*)url
                      method:(HttpMethod)method
                  parameters:(NSDictionary*)params
{
    //构建缓存的key --> method+url+params
    NSString* key = [NSString stringWithFormat:@"%ld%@",(long)method,url];
    if (params) {
        NSArray *sort_dict_keys = [[params allKeys] sortedArrayUsingSelector:@selector(compare:)];
        for (NSString* dict_key in sort_dict_keys) {
            key = [key stringByAppendingFormat:@"%@=%@",dict_key,[params objectForKey:dict_key]];
        }
    }
    return key;
}
+(void)getJsonWithUrl:(NSString*)url
               method:(HttpMethod)method
           parameters:(NSDictionary *)params
        loadFromCache:(BOOL)loadCacheFlag
          saveToCache:(BOOL)saveRequestFlag
       progressHandle:(void (^)(NSProgress *))progressingHandle
     completionHandle:(void (^)(id result, NSError * error)) completionHandle
{
    NSString* key = [self constructCacheKeyByUrl:url method:method parameters:params];
    
    //是否使用缓存
    if (loadCacheFlag==YES) {
        //先从缓存中读数据 loadCacheFlag == YES
        NSData* data = [[JsonDataCache sharedJsonDataCache] jsonDataFromCacheForKey:key];
        //如果从内存或者本地磁盘中读到数据了就返回数据，否则继续执行
        if (data) {
            completionHandle(data,nil);
            return;
        }
    }
    
    //get json from web server
    switch (method) {
        case HTTPMETHOD_GET:
        {
            [BaseApiModelClass GET:url parameters:params progressHandle:^(NSProgress * progress) {
                if (progressingHandle!=nil) {
                    progressingHandle(progress);
                }
            } completionHandle:^(id data, NSError *error) {
                if (!error) {
                    if (saveRequestFlag==YES) {
                        [[JsonDataCache sharedJsonDataCache] storeJsonData:data forKey:key completion:nil];
                    }
                }
                if (completionHandle!=nil) {
                    completionHandle(data,error);
                }
            }];
            break;
        }
        case HTTPMETHOD_POST:
        {
            [BaseApiModelClass POST:url parameters:params progressHandle:^(NSProgress * progress) {
                progressingHandle(progress);
            } completionHandle:^(id data, NSError *error) {
                if (!error) {
                    if (saveRequestFlag==YES) {
                        [[JsonDataCache sharedJsonDataCache] storeJsonData:data forKey:key completion:nil];
                    }
                }
                if (completionHandle!=nil) {
                    completionHandle(data,error);
                }
            }];
        }
        default:
            break;
    }
}

+(NSString*)errorDescriptionForStatus:(NSInteger)status
{
    NSString* errorDescription;
    switch (status) {
        case API_RESPONSE_OK:
            errorDescription = nil;
            break;
        case API_RESPONSE_CREATED:
            errorDescription = nil;
            break;
        case API_RESPONSE_ACCEPTED:
            errorDescription = nil;
            break;
        case API_RESPONSE_PARA_ERROR:
            errorDescription = @"参数错误";
            break;
        case API_RESPONSE_AUTH_ERROR:
            errorDescription = @"认证失败";
            break;
        case API_RESPONSE_TOKEN_ERROR:
            errorDescription = @"Token验证失败";
            break;
        case API_RESPONSE_FORBIDDEN:
            errorDescription = @"没有权限";
            break;
        case API_RESPONSE_NOT_FOUND:
            errorDescription = @"查询未找到相关信息";
            break;
        case API_RESPONSE_TIMEOUT:
            errorDescription = @"响应等待超时";
            break;
        case API_RESPONSE_DUPLICATED:
            errorDescription = @"重复提交";
            break;
        case API_RESPONSE_OUT_OF_RANGE:
            errorDescription = @"超出限制";
            break;
        case API_RESPONSE_OTHER_ERROR:
            errorDescription = @"其他错误";
            break;
        case API_RESPONSE_SYS_ERROR:
            errorDescription = @"系统内部错误";
            break;
        case API_RESPONSE_PAYMENT_ERROR:
            errorDescription = @"查询第三方支付平台信息失败";
            break;
        default:
            errorDescription = @"未知错误";
            break;
    }
    return errorDescription;
}
@end
