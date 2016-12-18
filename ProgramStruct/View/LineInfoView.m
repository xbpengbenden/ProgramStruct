//
//  LineInfoView.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/18.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "LineInfoView.h"
#import "LineInfoHeaderView.h"
@interface LineInfoView()
@property (nonatomic, strong) LineInfoHeaderView *lineInfoHeaderView;//线路信息
@end


@implementation LineInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if (self = [super init]) {
        [self configSubViews];
    }
    return self;
}

-(void)configSubViews
{
    self.backgroundColor = [UIColor blackColor];
    _lineInfoHeaderView = [[LineInfoHeaderView alloc] init];
    [self addSubview:_lineInfoHeaderView];
    [_lineInfoHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(heightFor10 * 8.5);
        make.left.right.top.mas_equalTo(0);
    }];

}

#pragma mark - setter
-(void)setHeaderViewModel:(LineInfoViewHeaderViewModel *)headerViewModel{
    _headerViewModel = headerViewModel;
    _lineInfoHeaderView.viewModel = headerViewModel;
}
@end
