//
//  NSObject+Network.h
//  BaseProject
//
//  Created by Benden on 16/12/13.
//  Copyright © 2016年 Benden. All rights reserved.
//

#import "NSObject+Network.h"
#import "AFNetworking/AFNetworking.h"

@implementation NSObject (Network)

+ (AFHTTPSessionManager *)sharedAFManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;

        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//respondObject 为二进制的NSData
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",@"text/plain",@"image/jpeg",@"application/octet-stream", nil];
//        [manager.requestSerializer setValue:nil forHTTPHeaderField:nil];
    });
    return manager;
}


+ (id)GET:(NSString *)path parameters:(NSDictionary *)params progressHandle:(void (^)(NSProgress *))progressingHandle completionHandle:(void (^)(id, NSError *))completionHandle{
    AFHTTPSessionManager *manager = [self sharedAFManager];
    id task = [manager GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressingHandle!=nil) {
            progressingHandle(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completionHandle!=nil) {
            completionHandle(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandle!=nil) {
            completionHandle(nil, error);
        }
    }];
    return task;
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params progressHandle:(void (^)(NSProgress *))progressingHandle completionHandle:(void (^)(id, NSError *))completionHandle{
    AFHTTPSessionManager *manager = [self sharedAFManager];
    id task = [manager POST:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressingHandle!=nil) {
            progressingHandle(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completionHandle!=nil) {
            completionHandle(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandle!=nil) {
            completionHandle(nil, error);
        }
    }];
    return task;
}

@end














