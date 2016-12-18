//
//  LineInfoViewHeaderViewModel.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/18.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "LineInfoViewHeaderViewModel.h"

@implementation LineInfoViewHeaderViewModel

+(instancetype)initViewModelWithTestData
{
    LineInfoViewHeaderViewModel* model = [[LineInfoViewHeaderViewModel alloc] init];
    model.lineType = COMMUTE;
    model.lineName = @"H10";
    model.startStationName = @"中科院研究院";
    model.endStationName = @"投资大厦1";
    model.busType = QUALITY;
    model.price = @"3";
    model.fullTripTimecost = @"50";
    model.mileage = @"17.0";
    model.tripStartTime = @"2016-01-01 07:25:00";
    model.serviceStartTime = @"";
    model.serviceEndTime = nil;
    return model;
}
+(instancetype)initViewModelWithTestData2
{
    LineInfoViewHeaderViewModel* model = [[LineInfoViewHeaderViewModel alloc] init];
    model.lineType = SHUTTLE;
    model.lineName = @"S1";
    model.startStationName = @"留仙洞地铁站";
    model.endStationName = @"TCL国际E城";
    model.busType = EXPRESS;
    model.price = @"2";
    model.fullTripTimecost = nil;
    model.mileage = @"4.0";
    model.tripStartTime = @"2016-01-01 07:25:00";
    model.serviceStartTime = @"2016-01-01 07:30:00";
    model.serviceEndTime = @"2016-01-01 09:30:00";
    return model;
}

@end
