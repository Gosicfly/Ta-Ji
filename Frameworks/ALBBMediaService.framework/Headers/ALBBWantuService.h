//
//  ALBBWantuService.h
//  ALBBMediaService
//  旺旺支持群：1327158539
//
//  Created by huamulou on 16/2/20.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALBBWantuConfiguration;
@class ALBBWTUploadRequest;
@class ALBBWTUploadResponse;

@interface ALBBWantu : NSObject

+ (instancetype)defaultWantu;

+ (void)registerWantuWithConfiguration:(ALBBWantuConfiguration *)configuration forKey:(NSString *)key;

+ (instancetype)wantuForKey:(NSString *)key;

+ (void)removeWantuForKey:(NSString *)key;


- (instancetype) initWithConfiguration:(ALBBWantuConfiguration *)configuration;


- (void) upload:(ALBBWTUploadRequest *) uploadRequest completeHandler:(void (^)(ALBBWTUploadResponse *  response, NSError *  error))completeHandler;

- (void) setDebug:(BOOL) usingDebug;


@property (nonatomic, strong, readonly) ALBBWantuConfiguration *configuration;
@end


@interface ALBBNetworkingConfiguration : NSObject

/**
 The timeout interval to use when waiting for additional data.
 */
@property (nonatomic, assign) NSTimeInterval timeoutIntervalForRequest;

@end

@interface ALBBWantuConfiguration : ALBBNetworkingConfiguration

+ (instancetype)defaultConfiguration;

@property(nonatomic, strong, readonly) NSString *uploadEndPoint;

@end