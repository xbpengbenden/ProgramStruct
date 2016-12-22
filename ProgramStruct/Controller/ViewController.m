//
//  ViewController.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/14.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "ViewController.h"
#import "GetSignSecretApiModel.h"
#import "LineInfoView.h"
#import "LineInfoViewModel.h"
#import "LineInfoViewHeaderViewModel.h"
@interface ViewController ()
{
    int flag;
}
@property (nonatomic, strong) LineInfoView *lineInfoView;//线路信息
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [GetSignSecretApiModel GetSignSecretWithSeq:@"abc" netsuccessHandle:^(id data, NSError *error) {
//        if (!error) {
//            DLog(@"success");
//        }else{
//            DLog(@"server status: %ld, description:%@",error.code,error.description);
//        }
//    } netFailHandle:^(NSError *error) {
//        DLog(@"server status: %ld, description:%@",error.code,error.description);
//    }];
    

//    _lineInfoView = [[[LineInfoView alloc] init] viewWithViewModel:[LineInfoViewModel initViewModelWithTestData] class:NSClassFromString(@"LineInfoViewModel")];
    _lineInfoView = [[[LineInfoView alloc]init] setupWithViewModel:[LineInfoViewModel initViewModelWithTestData]];
    
    self.view.backgroundColor = BLUEROUTELINECOLOR;
    [self.view addSubview:_lineInfoView];
    [_lineInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.bottom.mas_equalTo(0);
    }];
    flag = 1;
    @weakify(self)
    [self.lineInfoView.dayTicketSignal subscribeNext:^(id x) {
        @strongify(self)
        DLog(@"%@-%@",_lineInfoView.viewModel.selectOnstation.stationName,self.lineInfoView.viewModel.selectOffstation.stationName);
        switch (flag) {
            case 1:
                flag = 0;
                self.lineInfoView.viewModel.headerViewModel = [LineInfoViewHeaderViewModel initViewModelWithTestData2];
                break;
            case 0:
                flag = 1;
                self.lineInfoView.viewModel.headerViewModel = [LineInfoViewHeaderViewModel initViewModelWithTestData];
                break;
            default:
                break;
        }
        
    }];
}

#pragma mark - 实现 BaseViewControllerProtocol
-(void)bindModelToViewModel{
    DLog(@"execute once ");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
