//
//  ALBBRequest.h
//  ALBBMediaService
//
//  Created by huamulou on 16/2/20.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ALBBWTUploadProgressBlock) (int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend);

typedef NS_ENUM(NSInteger, ALBBWTUploadType) {
    ALBBWTUploadTypeNSURL = 0,
    ALBBWTUploadTypeData
};


@interface ALBBWTRequest : NSObject


@property (nonatomic, assign, readonly, getter = isCancelled) BOOL cancelled;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong, readonly) NSString *sessionId;

-(void) cancel;
@end

@interface ALBBWTUploadRequest : ALBBWTRequest

@property (nonatomic, copy)  ALBBWTUploadProgressBlock uploadProgress;

@property (nonatomic, strong) id content;

@property(nonatomic, assign, readonly) ALBBWTUploadType uploadType;
/**
 *  用户自定义的meta
 */
@property(nonatomic, strong) NSDictionary *customMetas;
/**
 *  用户自定义的参数
 *  可以作为魔法变量填充
 */
@property(nonatomic, strong) NSDictionary *customParms;

//服务端是否做md5校验
@property(nonatomic, assign) BOOL needMd5Verify;
@end

@interface ALBBWTUploadDataRequest : ALBBWTUploadRequest



@end

@interface ALBBWTUploadFileRequest : ALBBWTUploadRequest


@end

@interface ALBBWTResponse : NSObject

@property(nonatomic, strong) NSString *requestId;
@property(nonatomic) NSInteger httpStatus;
@property(nonatomic, strong) NSString *code;
@property(nonatomic, strong) NSString *message;

@end


@interface ALBBWTUploadResponse : ALBBWTResponse

//由tae sdk返回的url，上传成功之后有
@property(nonatomic, strong) NSString *url;
@property(nonatomic) BOOL isImage;
@property(nonatomic, strong) NSString *uri;

//由tae sdk返回的url，上传成功之后有
@property(nonatomic, strong) NSString *dir;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *returnBody;
@property(nonatomic, strong) NSString *customBody;

@property(nonatomic) NSInteger fileSize;
@property(nonatomic) NSString *eTag;

@property(nonatomic) NSString *mimeType;

@end


