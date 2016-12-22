//
//  GetLineDetailApiModel.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/22.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "GetLineDetailApiModel.h"


#define API @"get_line_detail"
#define PREFIX @"line"
#define WEBURL [NSString stringWithFormat:@"%@/%@/%@",API_SERVER_BASE_URL,PREFIX,API]


@implementation RoutePointModel
@end
@implementation StationModel
@end
@implementation LineDetatilModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"stationList" : [StationModel class],
             @"routeList" : RoutePointModel.class
             };
}
@end


@implementation GetLineDetailApiModel

+(void)GetLineDetailByLineId:(NSString*)lineId
                    LineType:(NSString*)lineType
                      userId:(NSString*)userId
                       devID:(NSString*)devId
                       token:(NSString*)token
            netsuccessHandle:(void(^)(id data,NSError* error))netSuccessHandle
               netFailHandle:(void(^)(NSError* error))netFailHandle
{
    NSParameterAssert(lineId!=nil);
    NSMutableDictionary* params =[[NSMutableDictionary alloc] init];
    [params setValue:lineId forKey:@"line_id"];
    if (lineType!=nil) {
        [params setValue:lineType forKey:@"line_type"];
    }
    if (userId!=nil) {
        [params setValue:userId forKey:@"user_id"];
    }
    if (devId!=nil) {
        [params setValue:devId forKey:@"dev_id"];
    }
    if (token!=nil) {
        [params setValue:token forKey:@"token"];
    }
    
    [self GetDataByUrl:WEBURL method:HTTPMETHOD_GET Parameters:params loadFromCache:NO saveToCache:NO netsuccessHandle:netSuccessHandle netFailHandle:netFailHandle];
    
}
@end
