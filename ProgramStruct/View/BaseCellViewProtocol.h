//
//  BaseCellViewProtocol.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/21.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "BaseViewModelClass.h"


@protocol BaseCellViewProtocol <NSObject>

@required
+(instancetype)cellWithTableView:(UITableView*)tableView viewModel:(id)viewModel;
@end
