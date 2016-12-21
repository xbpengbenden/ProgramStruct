//
//  StationListCell.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/19.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "StationListCell.h"
#import "LineInfoViewModel.h"

#define CELL_INDENTIFIER @"StationListCell"
@implementation StationListCell

+(instancetype)cellWithTableView:(UITableView*)tableView viewModel:(id)viewModel
{
    NSCParameterAssert(tableView!=nil);
    NSCParameterAssert([viewModel isKindOfClass:[StationObj class]]);
    
    StationListCell* cell = [tableView dequeueReusableCellWithIdentifier:CELL_INDENTIFIER];
    if (cell == nil) {
        cell = [[ StationListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_INDENTIFIER];
    }
    cell.viewModel = viewModel;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configSubViews];
        [self bindViewModel];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self configSubViews];
    [self bindViewModel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configSubViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.textColor = MainTitleRGB;
    self.detailTextLabel.textColor = SubTitleRGB;
    self.textLabel.font = kFont(18);
    self.detailTextLabel.font = kFont(18);
}
-(void)bindViewModel
{
    if (self.viewModel==nil) {
        self.viewModel = [[StationObj alloc] init];
    }
    
    RACSignal* stationTypeSignal =  RACObserve(self, viewModel.stationType);
    
    //绑定站点名称文本
    RAC(self.textLabel,text) = RACObserve(self, viewModel.stationName);
    //绑定到站时间文本
    RAC(self.detailTextLabel,text) = [RACSignal combineLatest:@[RACObserve(self, viewModel.index),RACObserve(self, viewModel.etaTime)]
                                                       reduce:^id(NSNumber* index, NSString* etaTime){
                                        if (etaTime==nil || [etaTime isEqualToString:@""]) {
                                            return @"";
                                        }else{
                                            if ([index integerValue]==0) {
                                                return etaTime;
                                            }else{
                                                return [NSString stringWithFormat:@"%@ %@",UDTEXT020,etaTime];
                                            }
                                        }
                                    }];
    //绑定上下站的区分图标
    RAC(self.imageView,image) = [stationTypeSignal map:^id(NSString* stationType) {
                                    if ([stationType isEqualToString:STATION_TYPE_GETON]) {
                                        return [UIImage imageNamed:@"icon_getBus_green"];
                                    }else if([stationType isEqualToString:STATION_TYPE_GETOFF]){
                                        return [UIImage imageNamed:@"icon_pin_red"];
                                    }else{
                                        return nil;
                                    }
                                }];
    //绑定是否被点击选中信号
    @weakify(self);
    [[RACSignal combineLatest:@[stationTypeSignal,RACObserve(self, viewModel.isSelected)] reduce:^id(NSString* stationType, NSNumber* isSelected){
        switch ([isSelected integerValue]) {
            case 0://No
                return @(0);
                break;
            case 1://Yes
                if ([stationType isEqualToString:STATION_TYPE_GETON]) {
                    return @(1);
                }else if([stationType isEqualToString:STATION_TYPE_GETOFF]){
                    return @(2);
                }else{
                    return @(-1);
                }
                break;
            default:
                return @(-2);
                break;
        }
    }] subscribeNext:^(NSNumber* x) {
        @strongify(self);
        switch ([x integerValue]) {
            case 0://未被选中
                self.contentView.backgroundColor = [UIColor whiteColor];
                self.textLabel.textColor = MainTitleRGB;
                self.detailTextLabel.textColor = MainTitleRGB;
                break;
            case 1://被选中，站点是上车站
                self.contentView.backgroundColor =startColorRgb;
                self.textLabel.textColor = [UIColor whiteColor];
                self.detailTextLabel.textColor = [UIColor whiteColor];
                break;
            case 2://被选中,站点是下车站
                self.contentView.backgroundColor = endColorRgb;
                self.textLabel.textColor = [UIColor whiteColor];
                self.detailTextLabel.textColor = [UIColor whiteColor];
                break;
            default://出现数据错误
                break;
        }
    }];
}
@end
