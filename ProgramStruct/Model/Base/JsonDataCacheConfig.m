//
//  JsonDataCacheConfig.m
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/14.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "JsonDataCacheConfig.h"
static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; // 1 week
@implementation JsonDataCacheConfig

- (instancetype)init {
    if (self = [super init]) {
        _shouldDisableiCloud = YES;
        _shouldCacheJsonDataInMemory = YES;
        _maxCacheAge = kDefaultCacheMaxCacheAge;
        _maxCacheSize = 0;// 0 means infinity
    }
    return self;
}

@end
