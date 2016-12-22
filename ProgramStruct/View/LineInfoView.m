//
//  LineInfoView.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/18.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "LineInfoView.h"
#import "LineInfoHeaderView.h"
#import "LineInfoViewModel.h"
#import "StationListCell.h"


#define CELL_HIGHT 44.0f
#define MAX_TABLE_HIGHT heightFor100*3.2

@interface LineInfoView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LineInfoHeaderView *lineInfoHeaderView;//线路描述信息
@property (nonatomic, strong) UITableView* stationListTableView;
@property (nonatomic, strong) UIView* hideView;
@property (nonatomic, strong) UIButton* hideStationsBtn;
@property (nonatomic, strong) UISwipeGestureRecognizer* gestureUpSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer* gestureDownSwipe;
//@property (nonatomic, strong) BMKMapView* mapView;
//@property (nonatomic,strong) BMKPolyline* polyLine; //地图遮盖线
//@property (nonatomic,strong) BMKUserLocation* userLocation; //用户位置
@property (nonatomic, strong) UIButton* dayTicketBtn;
@end


@implementation LineInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark -getter viewModel cannot be nil
-(LineInfoViewModel*)viewModel
{
    if (_viewModel==nil) {
        _viewModel = [[LineInfoViewModel alloc]init];
    }
    return _viewModel;
}
#pragma mark - BaseViewProtocol
-(void)configSubViews
{
    self.backgroundColor = [UIColor yellowColor];
    // 线路描述信息
    _lineInfoHeaderView = [[[LineInfoHeaderView alloc] init] setupWithViewModel:_viewModel.headerViewModel];
    [self addSubview:_lineInfoHeaderView];
    [_lineInfoHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(heightFor10 * 8.5);
        make.left.right.top.mas_equalTo(0);
    }];
    //站点列表
    _stationListTableView = [[UITableView alloc] init];
    _stationListTableView.delegate = self;
    _stationListTableView.dataSource = self;
    _stationListTableView.showsVerticalScrollIndicator = NO;
    _stationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _stationListTableView.tag = 1; //用于做隐藏时的状态
    _stationListTableView.alpha = 0.7;
    [self addSubview:_stationListTableView];
    [_stationListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineInfoHeaderView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    //隐藏按钮和响应手势的透明view
    _hideView = [[UIView alloc] init];
    _hideView.backgroundColor = [UIColor clearColor];
    _gestureUpSwipe = [[UISwipeGestureRecognizer alloc] init];
    _gestureUpSwipe.direction = UISwipeGestureRecognizerDirectionUp;//向上
    [_hideView addGestureRecognizer:_gestureUpSwipe];
    _gestureDownSwipe = [[UISwipeGestureRecognizer alloc] init];
    _gestureDownSwipe.direction = UISwipeGestureRecognizerDirectionDown;//向下
    [_hideView addGestureRecognizer:_gestureDownSwipe];
    [self addSubview:_hideView];
    [_hideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_stationListTableView.mas_bottom);
        make.left.mas_equalTo(widhtFor50);
        make.right.mas_equalTo(-widhtFor50);
        make.height.mas_equalTo(heightFor10 * 2.5);
    }];
    _hideStationsBtn = [UIButton new];
    [_hideStationsBtn setImageEdgeInsets:UIEdgeInsetsMake(heightFor10 * 1.5, widhtFor10 * 3, 0, widhtFor10 * 2)];
    [_hideStationsBtn setTitle:UDTEXT018 forState:UIControlStateNormal];
    [_hideStationsBtn.titleLabel setFont:kFont(12)];
    [_hideStationsBtn setTitleColor:MainTitleRGB forState:UIControlStateNormal];
    [_hideStationsBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, heightFor10, widhtFor10)];
    [_hideStationsBtn setBackgroundImage:[UIImage imageNamed:@"icon_arrow"] forState:UIControlStateNormal];
    [_hideView addSubview:_hideStationsBtn];
    [_hideStationsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(heightFor10 * 2.5);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(widhtFor10 * 7.5);
        make.top.mas_equalTo(0);
    }];

    //购买次票按钮
    _dayTicketBtn = [UIButton new];
    _dayTicketBtn.layer.cornerRadius = 10;
    _dayTicketBtn.layer.masksToBounds = YES;
    [_dayTicketBtn setTitle:UDTEXT017 forState:UIControlStateNormal];
    [_dayTicketBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dayTicketBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:adjustFont(20)]];
    [_dayTicketBtn setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forState:UIControlStateNormal];
    [self addSubview:_dayTicketBtn];
    [_dayTicketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenW - widhtFor10 * 2.4, heightFor10 * 5));
        make.left.mas_equalTo(widhtFor10 * 1.2);
        make.bottom.mas_equalTo(-heightFor10);
    }];
}
-(void)bindViewModel
{
    if (_viewModel==nil) {
        _viewModel = [[LineInfoViewModel alloc] init];
    }
    //绑定wrapStationList是否展开或者收起站点列表动作
    [RACObserve(self, viewModel.wrapStationList) subscribeNext:^(NSNumber* x) {
        if ([x intValue]==0) {//No, unwrap the station list
            [self displayAnimation];
        }else{//YES, wrap the station list
            [self hiddeAnimation];
        }
    }];
    //绑定点击收起/查看按钮动作
    [[_hideStationsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.viewModel.wrapStationList == NO) {
            [self.viewModel setWrapStationList:YES];
        }else{
            [self.viewModel setWrapStationList:NO];
        }
    }];
    //绑定上划动作
    [_gestureUpSwipe.rac_gestureSignal subscribeNext:^(id x) {
        [self.viewModel setWrapStationList:NO];
    }];
    //绑定下划动作
    [_gestureDownSwipe.rac_gestureSignal subscribeNext:^(id x) {
        [self.viewModel setWrapStationList:YES];
    }];
    //绑定headerView的viewModel
    RAC(self.lineInfoHeaderView,viewModel) = RACObserve(self, viewModel.headerViewModel);
    //绑定sationList改变的动作动作
    @weakify(self);
    [[RACObserve(self, viewModel.stationList) bufferWithTime:0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self.stationListTableView reloadData];
        [self.viewModel setWrapStationList:NO];
    }];
}
-(void)configOutputSignal
{
    self.dayTicketSignal = [[_dayTicketBtn rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id value) {
        return value;
    }];
}
#pragma mark ---tableView代理---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.viewModel.stationList.count> 0) {
        return self.viewModel.stationList.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HIGHT;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    StationObj* cellViewModel= self.viewModel.stationList[row];
    StationListCell* cell = [StationListCell cellWithTableView:_stationListTableView viewModel:cellViewModel];
    cell.viewModel = cellViewModel;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    StationObj* station = self.viewModel.stationList[row];
    station.isSelected = YES;
    if ([station.stationType isEqualToString:STATION_TYPE_GETON]) {
        if (self.viewModel.selectOnstation!=nil) {//之前选择过上车点，需要把之前的选择取消
            self.viewModel.selectOnstation.isSelected = NO;
        }
        self.viewModel.selectOnstation = station;
        
    }else if ([station.stationType isEqualToString:STATION_TYPE_GETOFF]){
        if (self.viewModel.selectOffstation!=nil) {//之前选着过下车点，需要把之前的选择取消
            self.viewModel.selectOffstation.isSelected = NO;
        }
        self.viewModel.selectOffstation = station;
    }
}
#pragma mark - private
//隐藏动画
-(void)hiddeAnimation
{
    [self.hideStationsBtn setTitle:UDTEXT019 forState:UIControlStateNormal];
    [self.hideStationsBtn setImage:[UIImage imageNamed:@"icon_arrow_down_white"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        [self.stationListTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_lineInfoHeaderView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
        
        [self.hideView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //            make.top.mas_equalTo(heightFor10 * 8.2);
            make.top.mas_equalTo(_lineInfoHeaderView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(heightFor10 * 2.5);
        }];
        [self.stationListTableView setNeedsLayout];
        [self.hideView setNeedsLayout];
        [self layoutIfNeeded];
    }];
}
//显示动画
-(void)displayAnimation
{
    [self.hideStationsBtn setTitle:UDTEXT018 forState:UIControlStateNormal];
    [self.hideStationsBtn setImage:[UIImage imageNamed:@"icon_arrow_top_white"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        NSInteger station_count=0;
        if (_viewModel!=nil&&_viewModel.stationList!=nil) {
            station_count = _viewModel.stationList.count;
        }
        NSInteger table_H = MIN(MAX_TABLE_HIGHT, station_count*CELL_HIGHT);
        
        [self.stationListTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_lineInfoHeaderView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(table_H);
        }];
        [self.hideView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_stationListTableView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(heightFor10 * 2.5);
        }];
        [self.stationListTableView setNeedsLayout];
        [self.hideView setNeedsLayout];
        [self layoutIfNeeded];
    }];
}
@end
