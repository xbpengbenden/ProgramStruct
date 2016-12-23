//
//  BaseViewControllerClass.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/22.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "BaseViewControllerClass.h"

@interface BaseViewControllerClass ()

@end

@implementation BaseViewControllerClass

- (instancetype)init
{
    NSAssert(![self isMemberOfClass:[BaseViewControllerClass class]], @"BaseViewControllerClass is an abstract class, you should not instantiate it directly.");
    id tmpSelf = [super init];
    self = nil;
    if (tmpSelf) {
        NSAssert([tmpSelf conformsToProtocol:@protocol(BaseViewControllerProtocol)], @"%@ is not conform to BaseViewControllerProtocol",NSStringFromClass([tmpSelf class]));
        self = tmpSelf;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setupMainView)]) {
        [self performSelector:@selector(setupMainView)];
    }
    if ([self respondsToSelector:@selector(bindModelToViewModel)]) {
        [self performSelector:@selector(bindModelToViewModel)];
    }
    if ([self respondsToSelector:@selector(dealWithViewSignal)]) {
        [self performSelector:@selector(dealWithViewSignal)];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
