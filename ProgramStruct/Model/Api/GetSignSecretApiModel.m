//
//  GetSignSecretApiModel.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/15.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "GetSignSecretApiModel.h"
#import <YYModel/YYModel.h>

#define API @"get_sign_secret"
#define PREFIX @"auth"
#define WEBURL [NSString stringWithFormat:@"%@/%@/%@",API_SERVER_BASE_URL,PREFIX,API]

@implementation GetSignSecretApiModel
+(void)GetSignSecretWithSeq:(NSString*)seq
              successHandle:(void(^)(id data,NSError* error))netSuccessHandle
              netFailHandle:(void(^)(NSError* error))netFailHandle
{
    NSMutableDictionary* params =[[NSMutableDictionary alloc] init];
    [params setValue:seq forKey:@"seq"];
    
    [self getJsonWithUrl:WEBURL method:HTTPMETHOD_GET parameters:params loadFromCache:NO saveToCache:NO progressHandle:nil completionHandle:^(id data, NSError* error){
        if (!error) {//成功获取数据
            //解析Json数据
            GetSignSecretApiModel *signSecretApiModel = [GetSignSecretApiModel yy_modelWithJSON:data];
            NSError* apiResponseError = nil;
            NSDictionary* userinfo = nil;
            switch (signSecretApiModel.status) {
                case API_RESPONSE_OK:
                case API_RESPONSE_CREATED:
                case API_RESPONSE_ACCEPTED:
                    break;
                default:
                    userinfo = [NSDictionary dictionaryWithObject:[self errorDescriptionForStatus:signSecretApiModel.status] forKey:NSLocalizedDescriptionKey];
                    apiResponseError = [NSError errorWithDomain:CustomErrorDomain code:signSecretApiModel.status userInfo:userinfo];
                    break;
            }
            if (netSuccessHandle!=nil) {//if api response good, the apiResponseError is nil
                netSuccessHandle(signSecretApiModel,apiResponseError);
            }
        }else{
            if (netFailHandle!=nil) {
                netFailHandle(error);
            }
        }
    }];

}
@end
