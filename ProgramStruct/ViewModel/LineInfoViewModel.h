//
//  LineInfoViewModel.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/19.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "BaseViewModelClass.h"

@interface PointObj : BaseViewModelClass
@property (nonatomic,assign) float longitude;
@property (nonatomic,assign) float latitude;
@end
@interface StationObj : BaseViewModelClass
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSString* stationName;
@property (nonatomic,strong) NSString* etaTime;
@property (nonatomic,strong) NSString* imgUrl;
@property (nonatomic,assign) float longitude;
@property (nonatomic,assign) float latitude;
@property (nonatomic,strong) NSString* stationType;
@property (nonatomic,assign) BOOL isSelected;
@end
@interface BusLocation : BaseViewModelClass
@property (nonatomic,strong) NSString* plateNumber;
@property (nonatomic,assign) float longitude;
@property (nonatomic,assign) float latitude;
@end


@class LineInfoViewHeaderViewModel;
@interface LineInfoViewModel : BaseViewModelClass
@property (nonatomic,strong) LineInfoViewHeaderViewModel* headerViewModel;
@property (nonatomic,assign) BOOL wrapStationList;
@property (nonatomic,strong) NSArray<StationObj*>* stationList;
@property (nonatomic,strong) NSArray<PointObj*>* route;
@property (nonatomic,strong) NSArray<BusLocation*>* busLocation;

@property (nonatomic,strong) StationObj* selectOnstation;
@property (nonatomic,strong) StationObj* selectOffstation;


+(instancetype)initViewModelWithTestData;
+(instancetype)initViewModelWithTestData2;
@end
