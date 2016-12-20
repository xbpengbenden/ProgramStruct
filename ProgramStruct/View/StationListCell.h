//
//  StationListCell.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/19.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StationObj;
@interface StationListCell : UITableViewCell
@property (nonatomic,strong) StationObj* viewModel;

+(instancetype)cellWithTableView:(UITableView*)tableView;
@end
