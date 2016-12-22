//
//  GetLineDetailApiModel.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/22.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "BaseApiModelClass.h"

//轨迹点
@interface RoutePointModel : BaseModelClass
@property (nonatomic, assign) NSInteger serialNum;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@end
//站点信息
@interface StationModel : BaseModelClass
@property (nonatomic, copy) NSString *lineId;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, copy) NSString *stationNum;
@property (nonatomic, copy) NSString *stationType;
@property (nonatomic, copy) NSString *stationaddress;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, copy) NSString *stationName;
@property (nonatomic, assign) NSInteger serialNum;
@property (nonatomic, copy) NSString *stationId;
@property (nonatomic, copy) NSString *stationImg;
@property (nonatomic, copy) NSString* arriveTime;
@end
//线路详情
@interface LineDetatilModel : BaseModelClass
@property (nonatomic, copy) NSString *lineId;
@property (nonatomic, copy) NSString* mileage;
@property (nonatomic, copy) NSString *endStationId;
@property (nonatomic, copy) NSString *lineName;
@property (nonatomic, copy) NSString *startStationId;
@property (nonatomic, copy) NSString *monthlyPrice;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *dayPrice;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, copy) NSString* endStationName;
@property (nonatomic, copy) NSString* isVoted;
@property (nonatomic, copy) NSString* inventory;
@property (nonatomic, copy) NSString* opType;
@property (nonatomic, copy) NSString* runTimes;
@property (nonatomic, copy) NSString* startStationName;
@property (nonatomic, copy) NSString* votedCount;
@property (nonatomic, strong) NSArray<StationModel*> *routeList;
@property (nonatomic, strong) NSArray<RoutePointModel*> *stationList;
@property (nonatomic, strong) NSString* lineModel;
@property (nonatomic, copy) NSString* lineType;
@property (nonatomic, copy) NSString* lineNo;
//活动使用的字段
@property (nonatomic, copy) NSString* serviceEndTime;
@property (nonatomic, copy) NSString* serviceStartTime;
//城际使用的字段
@property (nonatomic, copy) NSString* endTime;
@end

@interface GetLineDetailApiModel : BaseApiModelClass
@property (nonatomic,strong) LineDetatilModel* data;

+(void)GetLineDetailByLineId:(NSString*)lineId
                    LineType:(NSString*)lineType
                      userId:(NSString*)userId
                       devID:(NSString*)devId
                       token:(NSString*)token
            netsuccessHandle:(void(^)(id data,NSError* error))netSuccessHandle
               netFailHandle:(void(^)(NSError* error))netFailHandle;
@end
