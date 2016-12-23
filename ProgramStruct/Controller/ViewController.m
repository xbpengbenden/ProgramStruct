//
//  ViewController.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/14.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "ViewController.h"
#import "GetLineDetailApiModel.h"
#import "LineInfoView.h"
#import "LineInfoViewModel.h"

@interface ViewController ()
{
}
@property (nonatomic, strong) GetLineDetailApiModel* lineDetailApiModel;
@property (nonatomic, strong) LineInfoView *lineInfoView;//线路信息
@end

@implementation ViewController

#pragma mark - 实现 BaseViewControllerProtocol
-(void)setupMainView
{
    _lineInfoView = [[[LineInfoView alloc]init] setupWithViewModel:[LineInfoViewModel initViewModelWithTestData]];
    
    self.view.backgroundColor = BLUEROUTELINECOLOR;
    [self.view addSubview:_lineInfoView];
    [_lineInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
}
-(void)bindModelToViewModel{
    DLog(@"execute once ");
    RAC(_lineInfoView.viewModel,stationList) = [RACObserve(self, lineDetailApiModel.data.stationList) map:^id(NSArray<StationModel*>* value) {
        NSMutableArray* tempArray = [[NSMutableArray alloc] init];
        for (StationModel* stationModel in value) {
            StationObj* stationObj = [[StationObj alloc] init];
            stationObj.stationName = stationModel.stationName;
            stationObj.etaTime = stationModel.arriveTime;
            stationObj.imgUrl = stationModel.stationImg;
            stationObj.latitude = stationModel.latitude;
            stationObj.longitude = stationModel.longitude;
            stationObj.stationType = stationModel.stationType;
            stationObj.isSelected = NO;
            stationObj.index = stationModel.serialNum-1;
            [tempArray addObject:stationObj];
        }
        return tempArray;
    }];
    RAC(_lineInfoView.viewModel.headerViewModel,lineType) = RACObserve(self, lineDetailApiModel.data.lineType);
    RAC(_lineInfoView.viewModel.headerViewModel,lineName) = RACObserve(self, lineDetailApiModel.data.lineNo);
    RAC(_lineInfoView.viewModel.headerViewModel,startStationName) = RACObserve(self, lineDetailApiModel.data.startStationName);
    RAC(_lineInfoView.viewModel.headerViewModel,endStationName) = RACObserve(self, lineDetailApiModel.data.endStationName);
    RAC(_lineInfoView.viewModel.headerViewModel,busType) = RACObserve(self, lineDetailApiModel.data.lineModel);
    RAC(_lineInfoView.viewModel.headerViewModel,price)  = RACObserve(self, lineDetailApiModel.data.dayPrice);
    RAC(_lineInfoView.viewModel.headerViewModel,fullTripTimecost) = RACObserve(self, lineDetailApiModel.data.runTimes);
    RAC(_lineInfoView.viewModel.headerViewModel,mileage) = RACObserve(self, lineDetailApiModel.data.mileage);
    RAC(_lineInfoView.viewModel.headerViewModel,tripStartTime) = RACObserve(self, lineDetailApiModel.data.startTime);
    RAC(_lineInfoView.viewModel.headerViewModel,serviceStartTime) = RACObserve(self, lineDetailApiModel.data.serviceStartTime);
    RAC(_lineInfoView.viewModel.headerViewModel,serviceEndTime) = RACObserve(self, lineDetailApiModel.data.serviceEndTime);
    
}
-(void)dealWithViewSignal
{
    [_lineInfoView.dayTicketSignal subscribeNext:^(id x) {
        DLog(@"dayTicketBtn has been tapped.");
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [GetLineDetailApiModel GetLineDetailByLineId:@"157a43cb493de10dd5404a7af01f263d" LineType:nil userId:nil devID:nil token:nil netsuccessHandle:^(id data, NSError *error) {
        if (error) {
            DLog(@"something wrong");
            return;
        }
        self.lineDetailApiModel = data;
        DLog(@"success");
    } netFailHandle:^(NSError *error) {
        DLog(@"netfail");
    }];
    [NSThread sleepForTimeInterval:1.0f];
    [GetLineDetailApiModel GetLineDetailByLineId:@"bbeb179563399c2b5e542ec0d33cb799" LineType:nil userId:nil devID:nil token:nil netsuccessHandle:^(id data, NSError *error) {
        if (error) {
            DLog(@"something wrong");
            return;
        }
        self.lineDetailApiModel = data;
        DLog(@"success");
    } netFailHandle:^(NSError *error) {
        DLog(@"netfail");
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
