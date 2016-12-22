//
//  UIView+BaseView.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/22.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseViewModelClass;
@protocol BaseViewProtocol <NSObject>
//每个view都应有一个viewModel,并且需要设置viewModel的getter,让getter处理当当前viewmodel为nil时，自动生成一个空的viewmodel
@optional
/*
 * 本框架创建View的初始化方法
 * -viewModel ： view的viewModel属性
 * 
 */
-(instancetype)setupWithViewModel:(id)viewModel;

-(void)configSubViews;
-(void)bindViewModel;
-(void)configOutputSignal;
@end


@interface UIView (BaseView)

@end
