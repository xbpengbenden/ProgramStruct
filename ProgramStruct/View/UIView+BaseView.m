//
//  UIView+BaseView.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/22.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "UIView+BaseView.h"

@implementation UIView (BaseView)
/*
 * 对于BaseViewProtocol的默认实现
 *
 */
-(instancetype)setupWithViewModel:(id)viewModel
{
    DLog(@"defalut impementation of BaseViewProtocol - viewWithViewModel:class:");
    
    //检查view的self.viewModel是否拥有getter方法
    NSAssert([self respondsToSelector:@selector(viewModel)], @"the view do not have a getViewModel function, possiblly do not have viewModel named viewModel.");
    id selfViewModel = [self performSelector:@selector(viewModel)];
    
    if (viewModel!=nil) {//如果输入的viewModel不等于nil
        //检查viewModel输入的Class类型是否与self.viewModel的类型一致
        NSAssert([viewModel isKindOfClass:[selfViewModel class]],@" the input viewMolel does not match the Class of cell.viewModel.");
        //检查self.viewModel是否拥有setter方法
        NSAssert([self respondsToSelector:@selector(setViewModel:)], @"the cell did not have a setViewModel function, possiblly do not have viewModel named viewModel.");
        [self performSelector:@selector(setViewModel:) withObject:viewModel];
    }

    if ([self respondsToSelector:@selector(configSubViews)]) {
        [self performSelector:@selector(configSubViews)];
    }
    if ([self respondsToSelector:@selector(bindViewModel)]) {
        [self performSelector:@selector(bindViewModel)];
    }
    if ([self respondsToSelector:@selector(configOutputSignal)]) {
        [self performSelector:@selector(configOutputSignal)];
    }
    
    return self;
}
-(void)configSubViews
{
    DLog(@"defalut impementation of BaseViewProtocol - configSubViews");
}
-(void)bindViewModel
{
    DLog(@"defalut impementation of BaseViewProtocol - bindViewModel");
}
-(void)configOutputSignal
{
    DLog(@"defalut impementation of BaseViewProtocol - configOutputSignal");
}
@end
