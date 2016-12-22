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

/*
 * 本框架创建View的初始化方法
 * -viewModel ： view的viewModel属性
 * 
 */
@optional
-(instancetype)setupWithViewModel:(id)viewModel;

/*
 *  step.1此方法会被初始化的时候被第一个调用
 *  所有关于创建subView以及设置view的约束代码都应该写在此
 *
 */
@required
-(void)configSubViews;
/*
 *  step.2 此方法会被初始化的时候被第二个调用
 *  所有关于绑定View与ViewModel的代码都应该写在此
 *
 */
@required
-(void)bindViewModel;
/*
 *  step.3 此方法会被初始化的时候被第三个调用
 *  所有关于需要配置输出的RACSignal的代码都应该写在此
 *
 */
@optional
-(void)configOutputSignal;
@end


@interface UIView (BaseView)

@end
