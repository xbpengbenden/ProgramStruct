//
//  BaseViewControllerClass.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/22.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseViewControllerProtocol <NSObject>

@required
//will be execute at BaseViewController viewDidLoad.
-(void)setupMainView;
-(void)bindModelToViewModel;
-(void)dealWithViewSignal;
@end

@interface BaseViewControllerClass : UIViewController

@end
