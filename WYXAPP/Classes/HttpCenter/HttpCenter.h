//
//  HttpCenter.h
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/8.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

typedef enum {
    URL_COMMON_PATH_TYPE = 0,
    URL_DIFF_PATH_TYPE
}UrlPathType;

#import <Foundation/Foundation.h>

typedef void (^HandldBlock)(id res);

@interface HttpCenter : NSObject

+ (HttpCenter *)ShareInstance;

#pragma mark - appdelegate
/**
 配置所有的http请求的通用的头需要采集的信息.
 */
- (void)initCommonHttpHeader;

#pragma mark - login
/**
 登录，content-type 表单
 
 @param dic          参数字典
 @param successBlock 成功block
 @param failedBlock  失败block
 */
- (void)userLoginPostHttp:(NSDictionary *)dic
             SuccessBlock:(HandldBlock)successBlock
              FailedBlock:(HandldBlock)failedBlock;

/**
 注册接口，content-type 表单
 
 @param dic          参数字典
 @param successBlock 成功block
 @param failedBlock  失败block
 */
- (void)userRegistPostHttp:(NSDictionary *)dic
              SuccessBlock:(HandldBlock)successBlock
               FailedBlock:(HandldBlock)failedBlock;

@end
