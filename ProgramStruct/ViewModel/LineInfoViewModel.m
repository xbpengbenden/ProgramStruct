//
//  LineInfoViewModel.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/19.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "LineInfoViewModel.h"
@implementation PointObj
@end
@implementation StationObj
@end
@implementation BusLocation
@end


@implementation LineInfoViewModel
+(instancetype)initViewModelWithTestData
{
    LineInfoViewModel* model = [[LineInfoViewModel alloc] init];
    model.headerViewModel = [LineInfoViewHeaderViewModel initViewModelWithTestData];
    model.wrapStationList = NO;
    NSMutableArray* stationList = [[NSMutableArray alloc] init];
//    NSMutableArray* route       = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<=17; i++) {
        StationObj* station = [[StationObj alloc] init];
        station.index = i;
        station.stationName = [NSString stringWithFormat:@"%@-%ld",@"崇文花园",(long)i];
        if (i<4) {
            station.stationType = STATION_TYPE_GETON;
        }else{
            station.stationType = STATION_TYPE_GETOFF;
        }
        station.etaTime = [NSString stringWithFormat:@"%ld%ld:%ld%ld",(long)i,(long)(i+2),(long)(i+1),(long)(i+3)];
        [stationList addObject:station];
    }
    model.stationList = [NSArray arrayWithArray:stationList];
    model.wrapStationList = NO;
    return model;
}
+(instancetype)initViewModelWithTestData2
{
    LineInfoViewModel* model = [[LineInfoViewModel alloc] init];
    return model;
}

@end
