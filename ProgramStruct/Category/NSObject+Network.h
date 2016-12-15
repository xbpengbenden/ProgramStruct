//
//  NSObject+Network.h
//  BaseProject
//
//  Created by Benden on 16/12/13.
//  Copyright © 2016年 Benden. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 请求类型:Get Post
 Get:
 Post:
 具体使用哪个请求: 由服务器人员规定
 */
#define kCompletionHandle   completionHandle:(void(^)(id model, NSError *error))completionHandle
#define kProgressHandle     progressHandle:(void (^)(NSProgress *))progressingHandle
@interface NSObject (Network)



+ (id)GET:(NSString *)path parameters:(NSDictionary *)params kProgressHandle kCompletionHandle;

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params kProgressHandle kCompletionHandle;

@end












