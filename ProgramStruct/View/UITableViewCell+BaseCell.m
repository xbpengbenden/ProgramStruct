//
//  UITableViewCell+BaseCell.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/22.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "UITableViewCell+BaseCell.h"

@implementation UITableViewCell (BaseCell)
/*
 *  BaseCellViewProtocol的默认实现
 *
 */
+(instancetype)cellWithTableView:(UITableView*)tableView viewModel:(id)viewModel
{
//    DLog(@"defalut impementation of BaseCellViewProtocol - cellWithTableView:viewModel:");
    NSCParameterAssert(tableView!=nil);
    NSString* cellIndentifier = NSStringFromClass(self);
    id cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
        if ([cell respondsToSelector:@selector(configSubViews)]) {
            [cell performSelector:@selector(configSubViews)];
        }
        if ([cell respondsToSelector:@selector(bindViewModel)]) {
            [cell performSelector:@selector(bindViewModel)];
        }
        if ([cell respondsToSelector:@selector(configOutputSignal)]) {
            [cell performSelector:@selector(configOutputSignal)];
        }
    }
    //检查cell.viewModel是否拥有getter方法
    NSAssert([cell respondsToSelector:@selector(viewModel)], @"the cell do not have a getViewModel function, possiblly do not have viewModel named viewModel.");
    id cellViewModel = [cell performSelector:@selector(viewModel)];
    
    if (viewModel!=nil) {//如果输入的viewModel不等于nil
        //检查viewModel输入的Class类型是否与cell.viewModel的类型一致
        NSAssert([viewModel isMemberOfClass:[cellViewModel class]],@" the input viewMolel does not match the Class of cell.viewModel.");
        //检查cell.viewModel是否拥有setter方法
        NSAssert([cell respondsToSelector:@selector(setViewModel:)], @"the cell did not have a setViewModel function, possiblly do not have viewModel named viewModel.");
        [cell performSelector:@selector(setViewModel:) withObject:viewModel];
    }
    return cell;
}

-(void)configSubViews
{
    DLog(@"defalut impementation of BaseCellViewProtocol - configSubViews");
}
-(void)bindViewModel
{
    DLog(@"defalut impementation of BaseCellViewProtocol - bindViewModel");
}
-(void)configOutputSignal
{
    DLog(@"defalut impementation of BaseCellViewProtocol - configOutputSignal");
}
@end
