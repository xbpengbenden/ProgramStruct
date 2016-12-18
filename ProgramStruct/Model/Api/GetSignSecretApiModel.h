//
//  GetSignSecretApiModel.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/15.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import "BaseApiModelClass.h"

// Model:
@interface SignSecret : NSObject
@property NSString *secret;
@end


@interface GetSignSecretApiModel : BaseApiModelClass

@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) NSDate* time;
@property (nonatomic,strong) NSString* msg;
@property (nonatomic,strong) NSString* seq;
@property (nonatomic,strong) SignSecret* data;

+(void)GetSignSecretWithSeq:(NSString*)seq
              netsuccessHandle:(void(^)(id data,NSError* error))netSuccessHandle
              netFailHandle:(void(^)(NSError* error))netFailHandle;
@end
