//
//  BaseApiModelClass.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/14.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "BaseModelClass.h"
#define CustomErrorDomain @"com.udiannet.serverapi"

typedef NS_ENUM(NSInteger, HttpMethod) {
        HTTPMETHOD_GET = 1,
        HTTPMETHOD_POST= 2
};

typedef NS_ENUM(NSInteger,ApiResponseStatus) {
    API_RESPONSE_OK = 200,
    API_RESPONSE_CREATED = 201,
    API_RESPONSE_ACCEPTED = 202,
    API_RESPONSE_PARA_ERROR = 400,
    API_RESPONSE_AUTH_ERROR = 401,
    API_RESPONSE_TOKEN_ERROR = 402,
    API_RESPONSE_FORBIDDEN = 403,
    API_RESPONSE_NOT_FOUND = 404,
    API_RESPONSE_TIMEOUT = 408,
    API_RESPONSE_DUPLICATED = 409,
    API_RESPONSE_OUT_OF_RANGE = 413,
    API_RESPONSE_OTHER_ERROR = 444,
    API_RESPONSE_SYS_ERROR = 500,
    API_RESPONSE_PAYMENT_ERROR = 503
};

@interface BaseApiModelClass : BaseModelClass

@property (nonatomic,strong) NSDate* requestDate;
@property (nonatomic,copy) NSData* rawData;


/**
 *  数据请求模型类基础方法,新建的模型类中通过对此方法的封装，已达到进行网络请求或对数据缓存的目的
 *
 *  @param url              基础URL
 *  @param method           请求方式
 *  @param params           请求参数
 *  @param loadCacheFlag    是否使用内存->本地进行数据读取,YES使用、NO不使用
 *  @param saveCacheFlag    是否将网络请求的数据存储到内存->本地，YES使用、NO不使用
 *  @param completionHandle 数据回调
 */
+(void)getJsonWithUrl:(NSString*)url
               method:(HttpMethod)method
           parameters:(NSDictionary *)params
        loadFromCache:(BOOL)loadCacheFlag
          saveToCache:(BOOL)saveCacheFlag
       progressHandle:(void (^)(NSProgress *))progressingHandle
     completionHandle:(void (^)(id result, NSError * error)) completionHandle;

+(NSString*)errorDescriptionForStatus:(NSInteger)status;
@end
