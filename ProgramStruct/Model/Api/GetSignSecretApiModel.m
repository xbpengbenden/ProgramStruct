//
//  GetSignSecretApiModel.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/15.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "GetSignSecretApiModel.h"

#define API @"get_sign_secret"
#define PREFIX @"auth"
#define WEBURL [NSString stringWithFormat:@"%@/%@/%@",API_SERVER_BASE_URL,PREFIX,API]

@implementation SignSecret
@end
@implementation GetSignSecretApiModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{
//             @"secret" : @"data.secret"};
//}

+(void)GetSignSecretWithSeq:(NSString*)seq
              netsuccessHandle:(void(^)(id data,NSError* error))netSuccessHandle
              netFailHandle:(void(^)(NSError* error))netFailHandle
{
    NSMutableDictionary* params =[[NSMutableDictionary alloc] init];
    [params setValue:seq forKey:@"seq"];
    
    [self GetDataByUrl:WEBURL method:HTTPMETHOD_GET Parameters:params loadFromCache:NO saveToCache:NO netsuccessHandle:netSuccessHandle netFailHandle:netFailHandle];
}
@end
