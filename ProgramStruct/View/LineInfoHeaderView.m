//
//  LineInfoHeaderView.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/18.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "LineInfoHeaderView.h"
#import "LineInfoViewHeaderViewModel.h"


typedef enum : NSInteger {
    LineTypeUnknow = -1,
    LineTypeSchool = 0,
    LineTypeShuttle = 1,
    LineTypeCitybus = 2,
    LineTypeCommute = 3,
    LineTypeEvents = 4
}LineTypeEnum;

@interface LineInfoHeaderView ()
@property (nonatomic, strong) UIButton* lineTypeBtn;
@property (nonatomic, strong) UILabel* lineNameLabel;
@property (nonatomic, strong) UILabel* startStationLabel;
@property (nonatomic, strong) UIImageView* throwImageView;
@property (nonatomic, strong) UILabel* endStationLabel;
@property (nonatomic, strong) UILabel* tripStartTimeLabel;
@property (nonatomic, strong) UILabel* busTypeLabel;
@property (nonatomic, strong) UILabel* mileageAndTripTimecostLabel;
@property (nonatomic, strong) UILabel* priceLabel;
@property (nonatomic, strong) UILabel* rmbLabel;

@property (nonatomic, strong) UIView* roundView_1;
@property (nonatomic, strong) UILabel* serviceTimeLabel;
@property (nonatomic, strong) UIView* roundView_2;
@property (nonatomic, strong) UILabel* mileageAndTripTimecostLabel_2;



@end

@implementation LineInfoHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithViewModel:(LineInfoViewHeaderViewModel*)model;
{
    if (self = [super init]) {
        [self configSubViews];
        [self bindViewModel];
    }
    return self;
}


-(void)configSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    _lineTypeBtn = [[UIButton alloc] init];
    _lineTypeBtn.backgroundColor = [UIColor whiteColor];
    _lineTypeBtn.layer.cornerRadius = widhtFor10 * 0.2;
    [_lineTypeBtn.titleLabel setFont:kFont(12)];
    [_lineTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_lineTypeBtn];
    [_lineTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(widhtFor10 * 1.2);
        make.top.mas_equalTo(heightFor10 * 1.3);
        make.size.mas_equalTo(CGSizeMake(widhtFor30, heightFor10 * 1.5));
    }];
    
    _lineNameLabel = [[UILabel alloc] init];
    _lineNameLabel.font = kFont(16);
    _lineNameLabel.textColor = MainTitleRGB;
    [self addSubview:_lineNameLabel];
    [_lineNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lineTypeBtn.mas_right).mas_equalTo(widhtFor10 * 0.5);
        make.top.mas_equalTo(heightFor10 * 1.3);
    }];
    
    //起点Label
    _startStationLabel = [[UILabel alloc] init];
    _startStationLabel.textColor = MainTitleRGB;
    _startStationLabel.font = kFont(16);
    _startStationLabel.numberOfLines = 1;//行数一行
    [self addSubview:_startStationLabel];
    [_startStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lineNameLabel.mas_right).mas_equalTo(widhtFor10 * 0.5);
        make.top.mas_equalTo(heightFor10 * 1.3);
    }];
    //小图片
    _throwImageView = [UIImageView new];
    _throwImageView.image = [UIImage imageNamed:@"lineForImage"];
    _throwImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_throwImageView];
    [_throwImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_startStationLabel.mas_centerY).mas_equalTo(0);
        make.left.mas_equalTo(_startStationLabel.mas_right).mas_equalTo(widhtFor10 * 0.5);
        make.size.mas_equalTo(CGSizeMake(widhtFor10*2.2, heightFor10 * 0.6));
    }];
    //目的地Label
    _endStationLabel = [[UILabel alloc] init];
    _endStationLabel.textColor = MainTitleRGB;
    _endStationLabel.numberOfLines = 1;//行数一行
    _endStationLabel.font = kFont(16);
    [self addSubview:_endStationLabel];
    [_endStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_startStationLabel.mas_centerY).mas_equalTo(0);
        make.left.mas_equalTo(_throwImageView.mas_right).mas_equalTo(widhtFor10 * 0.5);
        //        make.height.mas_equalTo(heightFor10*1.8);
        make.right.mas_lessThanOrEqualTo(-widhtFor10);//距离右边父视图大于等于10像素
    }];
    
    
    //发车时间
    _tripStartTimeLabel = [UILabel new];
    _tripStartTimeLabel.textColor = MainTitleRGB;
    //    startTimeLabel.tag = 20;//以便有些界面不需要发车时间，如报名界面
    _tripStartTimeLabel.font = kFont(35);
    _tripStartTimeLabel.numberOfLines = 1;
    [self addSubview:_tripStartTimeLabel];
    [_tripStartTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineTypeBtn.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(_lineTypeBtn.mas_left).mas_equalTo(0);
        make.height.mas_equalTo(heightFor10 * 5.4);
    }];
    
    //车辆类型
    _busTypeLabel = [[UILabel alloc] init];
    _busTypeLabel.textColor = SubTitleRGB;
    _busTypeLabel.font = kFont(12);
    [self addSubview:_busTypeLabel];
    [_busTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_tripStartTimeLabel.mas_centerY).mas_equalTo(0);
        make.left.mas_equalTo(_tripStartTimeLabel.mas_right).mas_equalTo(widhtFor10);
    }];
    
    //全程距离和全程时间
    _mileageAndTripTimecostLabel = [UILabel new];
    _mileageAndTripTimecostLabel.textColor = SubTitleRGB;
    _mileageAndTripTimecostLabel.font = kFont(12);
    _mileageAndTripTimecostLabel.numberOfLines = 1;
    [self addSubview:_mileageAndTripTimecostLabel];
    [_mileageAndTripTimecostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tripStartTimeLabel.mas_right).mas_equalTo(widhtFor10);
        make.top.mas_equalTo(_busTypeLabel.mas_bottom).mas_equalTo(0);
    }];
    
   

    //服务时间
    _serviceTimeLabel = [UILabel new];
    _serviceTimeLabel.textColor = SubTitleRGB;
    _serviceTimeLabel.font = kFont(12);
    _serviceTimeLabel.numberOfLines = 1;
    [self addSubview:_serviceTimeLabel];
    [_serviceTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(widhtFor10 * 3.2);
        make.top.mas_equalTo(_lineTypeBtn.mas_bottom).mas_equalTo(widhtFor10);
    }];
    //描述前面的小圆圈-1
    _roundView_1 = [[UIView alloc] init];
    _roundView_1.backgroundColor = SubTitleRGB;
    _roundView_1.layer.cornerRadius = widhtFor10 * 0.25;
    [self addSubview:_roundView_1];
    [_roundView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_serviceTimeLabel.mas_left).mas_equalTo(-widhtFor10*0.5);
        make.centerY.mas_equalTo(_serviceTimeLabel.mas_centerY).mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(widhtFor10 * 0.5, heightFor10 * 0.5));
    }];
    
    //全程距离
    _mileageAndTripTimecostLabel_2 = [UILabel new];
    _mileageAndTripTimecostLabel_2.textColor = SubTitleRGB;
    _mileageAndTripTimecostLabel_2.font = kFont(12);
    _mileageAndTripTimecostLabel_2.numberOfLines = 1;
    [self addSubview:_mileageAndTripTimecostLabel_2];
    [_mileageAndTripTimecostLabel_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(widhtFor10 * 3.2);
        make.top.mas_equalTo(_serviceTimeLabel.mas_bottom).mas_equalTo(widhtFor10*.5);
    }];
    //描述前面的小圆圈-2
    _roundView_2 = [[UIView alloc] init];
    _roundView_2.backgroundColor = SubTitleRGB;
    _roundView_2.layer.cornerRadius = widhtFor10 * 0.25;
    [self addSubview:_roundView_2];
    [_roundView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_mileageAndTripTimecostLabel_2.mas_left).mas_equalTo(-widhtFor10*0.5);
        make.centerY.mas_equalTo(_mileageAndTripTimecostLabel_2.mas_centerY).mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(widhtFor10 * 0.5, heightFor10 * 0.5));
    }];
    
    //元
    _rmbLabel = [[UILabel alloc] init];
    _rmbLabel.text = UDTEXT002;
    _rmbLabel.textColor = MainThemeGreenRGB;
    _rmbLabel.font = kFont(25);
    _rmbLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_rmbLabel];
    [_rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-widhtFor10 * 1.2);
        make.bottom.mas_equalTo(-heightFor10 * 1.35);
        make.width.mas_equalTo(widhtFor10 * 1.5);
    }];
    
    //价格
    _priceLabel = [UILabel new];
    _priceLabel.textColor = MainThemeGreenRGB;
    _priceLabel.font = kFont(32);
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_rmbLabel.mas_left).mas_equalTo(0);
        make.bottom.mas_equalTo(-heightFor10 * 1.35);
        make.size.mas_equalTo(CGSizeMake(widhtFor50, heightFor10 * 2.7));
    }];
    


    
}

-(void)bindViewModel
{
    if (self.viewModel==nil) {
        self.viewModel = [[LineInfoViewHeaderViewModel alloc]init];
    }
    //绑定lineType动作
    @weakify(self);
    RACSignal* lineTypeSignal = RACObserve(self, viewModel.lineType);
    [lineTypeSignal subscribeNext:^(NSString* lineType) {
        @strongify(self);
        LineTypeEnum type = [self getLineTypeByString:lineType];
        switch (type) {
            case LineTypeCommute:
                [self styleForCommute];
                break;
            case LineTypeShuttle:
                [self styleForShuttle];
                break;
            case LineTypeCitybus:
                [self styleForCitybus];
                break;
            case LineTypeEvents:
                [self styleForEvents];
                break;
            case LineTypeSchool:
                
            default:
                [self styleForCommute];
                break;
        }
    }];
    //绑定线路名文本
    RAC(self.lineNameLabel,text) = RACObserve(self, viewModel.lineName);
    //绑定起点文本
    RAC(self.startStationLabel,text) = [RACObserve(self, viewModel.startStationName) map:^id(NSString* startStationName) {
                                            if (startStationName==nil || [startStationName isEqualToString:@""]) {
                                                return [NSString stringWithFormat:@"(%@",UDTEXT009];
                                            }else{
                                                return [NSString stringWithFormat:@"(%@",startStationName];
                                            }
                                        }];
    //绑定终点文本
    RAC(self.endStationLabel,text) = [RACObserve(self, viewModel.endStationName) map:^id(NSString* endStationName) {
                                            if (endStationName==nil || [endStationName isEqualToString:@""]) {
                                                return [NSString stringWithFormat:@"%@)",UDTEXT010];
                                            }else{
                                                return [NSString stringWithFormat:@"%@)",endStationName];
                                            }
                                        }];
    //绑定发车时间文本
    RAC(self.tripStartTimeLabel,text) = [RACObserve(self, viewModel.tripStartTime) map:^id(NSString* tripStartTime) {
                                            if (tripStartTime==nil || tripStartTime.length<16) {
                                                return UDTEXT011;
                                            }else{
                                                return [tripStartTime substringWithRange:NSMakeRange(11, 5)];
                                            }
                                        }];
    //绑定车型文本
    RAC(self.busTypeLabel,text) = [RACObserve(self, viewModel.busType) map:^id(NSString* busType) {
                                        if (busType==nil || [busType isEqualToString:@""]) {
                                            return [NSString stringWithFormat:@"车型：%@",UDTEXT014];
                                        }else if ([busType isEqualToString:QUALITY])
                                        {
                                            return [NSString stringWithFormat:@"车型：%@",UDTEXT012];
                                        }else if ([busType isEqualToString:EXPRESS])
                                        {
                                            return [NSString stringWithFormat:@"车型：%@",UDTEXT013];
                                        }else{
                                            return [NSString stringWithFormat:@"车型：%@",UDTEXT014];
                                        }
                                    }];
    //绑定里程和耗时文本
    RAC(self.mileageAndTripTimecostLabel,text) = [RACSignal combineLatest:@[RACObserve(self, viewModel.mileage),RACObserve(self, viewModel.fullTripTimecost)] reduce:^id(NSString* mileage, NSString* timecost){
                                                        if (mileage==nil || [mileage isEqualToString:@""]) {
                                                            mileage = @"";
                                                        }else{
                                                            mileage = [NSString stringWithFormat:@"%@公里",mileage];
                                                        }
                                                        if (timecost==nil || [timecost isEqualToString:@""]) {
                                                            timecost = @"";
                                                        }else{
                                                            timecost = [NSString stringWithFormat:@"耗时%@分钟",timecost];
                                                        }
                                                        return [NSString stringWithFormat:@"%@%@",mileage,timecost];
                                                    }];
    //绑定价钱文本
    RAC(self.priceLabel,text) = RACObserve(self, viewModel.price);
    //绑定服务时间
    RAC(self.serviceTimeLabel,text) = [RACSignal combineLatest:@[RACObserve(self, viewModel.serviceStartTime),RACObserve(self, viewModel.serviceEndTime),RACObserve(self.viewModel, lineType)]
                                                        reduce:^id(NSString* startTime, NSString* endTime, NSString* lineType){
                                                            if (startTime==nil || startTime.length<16) {
                                                                startTime = UDTEXT011;
                                                            }else{
                                                                startTime = [startTime substringWithRange:NSMakeRange(11, 5)];
                                                            }
                                                            if (endTime==nil || endTime.length<16) {
                                                                endTime = UDTEXT011;
                                                            }else{
                                                                endTime = [endTime substringWithRange:NSMakeRange(11, 5)];
                                                            }
                                                            LineTypeEnum type = [self getLineTypeByString:lineType];
                                                            NSString* returnString = nil;
                                                            switch (type) {
                                                                case LineTypeShuttle:
                                                                    returnString = [NSString stringWithFormat:@"%@~%@(%@)",startTime,endTime,UDTEXT015];
                                                                    break;
                                                                case LineTypeCitybus:
                                                                    returnString = [NSString stringWithFormat:@"%@:%@~%@",UDTEXT016,startTime,endTime];
                                                                    break;
                                                                default:
                                                                    returnString = [NSString stringWithFormat:@"%@:%@~%@",UDTEXT016,startTime,endTime];
                                                                    break;
                                                            }
                                                            return returnString;
                                                        }];
    //绑定里程和耗时文本—2
    RAC(self.mileageAndTripTimecostLabel_2,text) = [RACSignal combineLatest:@[RACObserve(self, viewModel.mileage),RACObserve(self, viewModel.fullTripTimecost)] reduce:^id(NSString* mileage, NSString* timecost){
                                                            if (mileage==nil || [mileage isEqualToString:@""]) {
                                                                mileage = @"";
                                                            }else{
                                                                mileage = [NSString stringWithFormat:@"%@公里",mileage];
                                                            }
                                                            if (timecost==nil || [timecost isEqualToString:@""]) {
                                                                timecost = @"";
                                                            }else{
                                                                timecost = [NSString stringWithFormat:@"耗时%@分钟",timecost];
                                                            }
                                                            return [NSString stringWithFormat:@"%@ %@",mileage,timecost];
                                                        }];
}

#pragma mark - private
-(LineTypeEnum)getLineTypeByString:(NSString*)lineTypeString
{
    LineTypeEnum type = LineTypeUnknow;
    if ([lineTypeString isEqualToString:SHUTTLE]) {
        type = LineTypeShuttle;
    }else if([lineTypeString isEqualToString:CITY_BUS]){
        type = LineTypeCitybus;
    }else if([lineTypeString isEqualToString:COMMUTE]){
        type = LineTypeCommute;
    }else if([lineTypeString isEqualToString:SCHOOL]){
        type = LineTypeSchool;
    }else if([lineTypeString isEqualToString:EVENTS]){
        type = LineTypeEvents;
    }else{
        type = LineTypeUnknow;
    }
    return type;
    
}
-(void)styleForCommute
{
    [self.lineTypeBtn setTitle:UDTEXT005 forState:UIControlStateNormal];
    self.lineTypeBtn.backgroundColor = bus_color_rgb;
    
    self.roundView_1.hidden = YES;
    self.serviceTimeLabel.hidden = YES;
    self.roundView_2.hidden = YES;
    self.mileageAndTripTimecostLabel_2.hidden = YES;
    
    self.tripStartTimeLabel.hidden = NO;
    self.busTypeLabel.hidden = NO;
    self.mileageAndTripTimecostLabel.hidden = NO;
}
-(void)styleForShuttle
{
    [self.lineTypeBtn setTitle:UDTEXT003 forState:UIControlStateNormal];
    self.lineTypeBtn.backgroundColor = shuttle_color_rgb;
    
    self.roundView_1.hidden = NO;
    self.serviceTimeLabel.hidden = NO;
    self.roundView_2.hidden = NO;
    self.mileageAndTripTimecostLabel_2.hidden = NO;
    
    self.tripStartTimeLabel.hidden = YES;
    self.busTypeLabel.hidden = YES;
    self.mileageAndTripTimecostLabel.hidden = YES;
}
-(void)styleForCitybus
{
    [self.lineTypeBtn setTitle:UDTEXT004 forState:UIControlStateNormal];
    self.lineTypeBtn.backgroundColor = city_color_rgb;
    
    self.roundView_1.hidden = NO;
    self.serviceTimeLabel.hidden = NO;
    self.roundView_2.hidden = NO;
    self.mileageAndTripTimecostLabel_2.hidden = NO;
    
    self.tripStartTimeLabel.hidden = YES;
    self.busTypeLabel.hidden = YES;
    self.mileageAndTripTimecostLabel.hidden = YES;
}
-(void)styleForEvents
{
    [self.lineTypeBtn setTitle:UDTEXT007 forState:UIControlStateNormal];
    self.lineTypeBtn.backgroundColor = events_color_rgb;
    
    self.roundView_1.hidden = NO;
    self.serviceTimeLabel.hidden = NO;
    self.roundView_2.hidden = NO;
    self.mileageAndTripTimecostLabel_2.hidden = NO;
    
    self.tripStartTimeLabel.hidden = YES;
    self.busTypeLabel.hidden = YES;
    self.mileageAndTripTimecostLabel.hidden = YES;
}
@end
