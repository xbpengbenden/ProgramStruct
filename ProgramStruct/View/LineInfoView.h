//
//  LineInfoView.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/18.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LineInfoViewModel;
@interface LineInfoView : UIView

@property (nonatomic,strong) LineInfoViewModel* viewModel;
@property (nonatomic,strong) RACSignal* dayTicketSignal;

-(instancetype)initWithViewModel:(LineInfoViewModel*)model;
@end
