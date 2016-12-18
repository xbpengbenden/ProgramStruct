//
//  LineInfoViewHeaderViewModel.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/18.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "BaseViewModelClass.h"

@interface LineInfoViewHeaderViewModel : BaseViewModelClass

@property (nonatomic,strong) NSString* lineType;
@property (nonatomic,strong) NSString* lineName;
@property (nonatomic,strong) NSString* startStationName;
@property (nonatomic,strong) NSString* endStationName;
@property (nonatomic,strong) NSString* busType;
@property (nonatomic,strong) NSString* price;
@property (nonatomic,strong) NSString* fullTripTimecost;
@property (nonatomic,strong) NSString* mileage;

@property (nonatomic,strong) NSString* tripStartTime;

@property (nonatomic,strong) NSString* serviceStartTime;
@property (nonatomic,strong) NSString* serviceEndTime;

+(instancetype)initViewModelWithTestData;
+(instancetype)initViewModelWithTestData2;
@end
