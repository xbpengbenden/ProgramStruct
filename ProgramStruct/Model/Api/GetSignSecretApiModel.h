//
//  GetSignSecretApiModel.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/15.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "BaseApiModelClass.h"


@interface GetSignSecretApiModel : BaseApiModelClass

@property (nonatomic,assign,readonly) NSInteger status;
@property (nonatomic,strong,readonly) NSDate* time;
@property (nonatomic,strong,readonly) NSString* msg;
@property (nonatomic,strong,readonly) NSString* seq;
@property (nonatomic,strong,readonly) NSString* secret;

+(void)GetSignSecretWithSeq:(NSString*)seq
              successHandle:(void(^)(id data,NSError* error))netSuccessHandle
              netFailHandle:(void(^)(NSError* error))netFailHandle;
@end
