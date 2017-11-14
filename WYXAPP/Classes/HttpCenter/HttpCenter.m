//
//  HttpCenter.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/8.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "HttpCenter.h"


@interface HttpCenter

@end

@implementation HttpCenter

+ (HttpCenter *)ShareInstance {
    static HttpCenter *sharedHttpCenterInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedHttpCenterInstance = [[self alloc] init];
    });
    return sharedHttpCenterInstance;
}
#pragma mark - Main Methods
#pragma mark - appdelegate
- (void)initCommonHttpHeader {
    NSMutableDictionary *dic = [@{} mutableCopy];
    dic[@"clientId"] = httpHeaderClientID;
    [DDHttpManager ShareInstance].commonHeader = dic;
}


#pragma mark - LoginAndRegist
- (void)userLoginPostHttp:(NSDictionary *)dic
             SuccessBlock:(HandldBlock)successBlock
              FailedBlock:(HandldBlock)failedBlock {
    [self httpMethodModelMeds:dic
                         Host:SERVER_HOST
                      DiffUrl:@"users/login"
                       Method:DDHttpPost
                 SuccessBlock:successBlock
                  FailedBlock:failedBlock];
}

- (void)userRegistPostHttp:(NSDictionary *)dic
              SuccessBlock:(HandldBlock)successBlock
               FailedBlock:(HandldBlock)failedBlock {
    [self httpMethodModelMeds:dic
                         Host:SERVER_HOST
                      DiffUrl:@"users/register"
                       Method:DDHttpPost
                 SuccessBlock:successBlock
                  FailedBlock:failedBlock];
}


#pragma mark - Support Methods
/**
 muldata格式的参数传递方式，不能新加header
 
 @param dic          参数字典
 @param host         url的host
 @param difUrl       除去公共路径之后不同的部分
 @param method       http的类型，参考DDHttpMethodType
 @param successBlock 成功后回调的block
 @param failedBlock  失败后回调的block
 */
- (void)httpMethodModelMeds:(NSDictionary *)dic
                       Host:(NSString *)host
                    DiffUrl:(NSString *)difUrl
                     Method:(DDHttpMethodType)method
               SuccessBlock:(HandldBlock)successBlock
                FailedBlock:(HandldBlock)failedBlock {
    [self httpMethodMeds:dic
                    Host:host
                PathType:URL_COMMON_PATH_TYPE
                 DiffUrl:difUrl
                  Method:method
           RequestMethod:DDRequestHttp
                  Header:nil
            SuccessBlock:successBlock
             FailedBlock:failedBlock];
}
/**
 muldata格式参数传递方式，自由决定是否公用Path，不能新加header
 
 @param dic          参数字典
 @param host         url的host
 @param pathType     url是否采用公共path
 @param difUrl       除去公共路径之后不同的部分
 @param method       http的类型，参考DDHttpMethodType
 @param successBlock 成功后回调的block
 @param failedBlock  失败后回调的block
 */
- (void)httpMethodModelMeds:(NSDictionary *)dic
                       Host:(NSString *)host
                   PathType:(UrlPathType)pathType
                    DiffUrl:(NSString *)difUrl
                     Method:(DDHttpMethodType)method
               SuccessBlock:(HandldBlock)successBlock
                FailedBlock:(HandldBlock)failedBlock {
    [self httpMethodMeds:dic
                    Host:host
                PathType:pathType
                 DiffUrl:difUrl
                  Method:method
           RequestMethod:DDRequestHttp
                  Header:nil
            SuccessBlock:successBlock
             FailedBlock:failedBlock];
}
/**
 muldata格式的参数传递方式,可以新加Header
 
 @param dic          参数字典
 @param host         url的host
 @param difUrl       除去公共路径之后不同的部分
 @param method       http的类型，参考DDHttpMethodType
 @param header       新增的http的头的参数字典
 @param successBlock 成功后回调的block
 @param failedBlock  失败后回调的block
 */
- (void)httpMethodMeds:(NSDictionary *)dic
                  Host:(NSString *)host
               DiffUrl:(NSString *)difUrl
                Method:(DDHttpMethodType)method
                Header:(NSDictionary *)header
          SuccessBlock:(HandldBlock)successBlock
           FailedBlock:(HandldBlock)failedBlock {
    [self httpMethodMeds:dic
                    Host:host
                PathType:URL_COMMON_PATH_TYPE
                 DiffUrl:difUrl
                  Method:method
           RequestMethod:DDRequestHttp
                  Header:header
            SuccessBlock:successBlock
             FailedBlock:failedBlock];
}
/**
 muldata格式的参数传递方式,可以选择是否使用公共路径,可以新加Header，处理request方式，基方法
 
 @param dic          参数字典
 @param host         url的host
 @param pathType     url的是否采用公共路径
 @param difUrl       除去公共路径之后不同的部分
 @param method       http的类型，参考DDHttpMethodType
 @param header       新增的http的头的参数字典
 @param successBlock 成功后回调的block
 @param failedBlock  失败后回调的block
 */
- (void)httpMethodMeds:(NSDictionary *)dic
                  Host:(NSString *)host
              PathType:(UrlPathType)pathType
               DiffUrl:(NSString *)difUrl
                Method:(DDHttpMethodType)method
         RequestMethod:(DDRequestType)request
                Header:(NSDictionary *)header
          SuccessBlock:(HandldBlock)successBlock
           FailedBlock:(HandldBlock)failedBlock {
    NSString *url;
    switch (pathType) {
        case URL_COMMON_PATH_TYPE:
            url = [HandleUrl requestUrlWithUrl:difUrl Host:host];
            break;
        case URL_DIFF_PATH_TYPE: {
            url = [host stringByAppendingString:difUrl];
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            NSString *sign = [@"" ThansformSigh:tempDic];
            tempDic[@"sign"] = sign;
            dic = tempDic;
        }
            break;
        default:
            url = [HandleUrl requestUrlWithUrl:difUrl Host:host];
            break;
    }
    DDLog(@"url===%@,dic====%@",url,dic);
    NSMutableDictionary *finalHeader = [self setCommonHeader:header ParaDic:dic];
    [[DDHttpManager ShareInstance]AFNetMethodsSupport:url
                                           Parameters:dic
                                               Method:method
                                        RequestMethod:request
                                            HeaderDic:finalHeader
                                          SucessBlock:^(id response) {
                                              [self handlerResponse:response
                                                       SuccessBlock:successBlock
                                                        FailedBlock:failedBlock];
                                          }
                                          FailedBlock:^(NSError *error) {
                                              [self handleFailResponse:error failedBlock:failedBlock];
                                          }];
}
/**
 url格式的POST参数传递方式
 
 @param dic          参数字典
 @param host         url的host
 @param difUrl       除去公共路径之后不同的部分
 @param successBlock 成功后回调的block
 @param failedBlock  失败后回调的block
 */
- (void)postUrlTypeMeds:(NSDictionary *)dic
                   Host:(NSString *)host
                DiffUrl:(NSString *)difUrl
           SuccessBlock:(HandldBlock)successBlock
            FailedBlock:(HandldBlock)failedBlock {
    NSString *url = [HandleUrl requestUrlWithUrl:difUrl Host:host];
    [[DDHttpManager ShareInstance]AFNetUrlPOSTSupport:url
                                           Parameters:dic
                                          SucessBlock:^(id response) {
                                              [self handlerResponse:response
                                                       SuccessBlock:successBlock
                                                        FailedBlock:failedBlock];
                                          }
                                          FailedBlock:^(NSError *error) {
                                              [self handleFailResponse:error failedBlock:failedBlock];
                                          }];
}

/**
 muldata格式的POST参数上传图片方式
 
 @param dic          参数字典
 @param host         url的host
 @param difUrl       除去公共路径之后不同的部分
 @param successBlock 成功后回调的block
 @param failedBlock  失败后回调的block
 */
- (void)postMulPicMeds:(NSDictionary *)dic
                  Host:(NSString *)host
               DiffUrl:(NSString *)difUrl
          SuccessBlock:(HandldBlock)successBlock
             BodyBlock:(void(^)(id<AFMultipartFormData> formData))bodyBlock
           FailedBlock:(HandldBlock)failedBlock {
    NSString *url = [HandleUrl requestUrlWithUrl:difUrl Host:host];
    DDLog(@"url===%@,dic====%@",url,dic);
    [[DDHttpManager ShareInstance]AFNetPOSTSupport:url
                                        Parameters:dic
                                     RequestMethod:DDRequestHttp
                         ConstructingBodyWithBlock:bodyBlock
                                       SucessBlock:^(id response) {
                                           [self handlerResponse:response
                                                    SuccessBlock:successBlock
                                                     FailedBlock:failedBlock];
                                       }
                                       FailedBlock:^(NSError *error) {
                                           [self handleFailResponse:error failedBlock:failedBlock];
                                       }];
}

/// formdata上传图片
- (void)postFormDataPicMeds:(NSDictionary *)dic
                       host:(NSString *)host
                    diffUrl:(NSString *)diffUrl
               successBlock:(HandldBlock)successBlock
                  bodyBlock:(void(^)(id<AFMultipartFormData> formData))bodyBlock
                  failBlock:(HandldBlock)failBlock {
    
    NSString *url = [HandleUrl requestUrlWithUrl:diffUrl Host:host];
    DDLog(@"url===%@,dic====%@",url,dic);
    NSMutableDictionary *finalHeader = [self setCommonHeader:nil ParaDic:dic];
    [[DDHttpManager ShareInstance] AFNetPOSTSupport:url
                                         Parameters:dic
                                             Header:finalHeader
                                      RequestMethod:DDRequestHttp
                          ConstructingBodyWithBlock:bodyBlock
                                        SucessBlock:^(id response) {
                                            [self handlerResponse:response
                                                     SuccessBlock:successBlock
                                                      FailedBlock:failBlock];
                                        }
                                        FailedBlock:^(NSError *error) {
                                            [self handleFailResponse:error failedBlock:failBlock];
                                        }];
    
}

#pragma mark - support methods
/**
 Java后端的统一处理http的返回
 
 @param response 返回的数据
 */
- (void)handlerResponse:(id)response
           SuccessBlock:(HandldBlock)successBlock
            FailedBlock:(HandldBlock)failedBlock  {
}

- (void)handleFailResponse:(NSError *)error failedBlock:(HandldBlock)failed {
    }

/**
 返回每次http访问的头其他设置
 
 @param headerDic 如有其他头的设置
 @param paraDic http的body
 @return 返回头的设置字典
 */
- (NSMutableDictionary *)setCommonHeader:(NSDictionary *)headerDic ParaDic:(NSDictionary *)paraDic {
    NSMutableDictionary *finalHeader = [NSMutableDictionary dictionaryWithDictionary:headerDic];
    NSString *clientTime = [[GlobalUtil ShareInstance]getHttpHeaderDate];
    finalHeader[@"clientTime"] = clientTime;
    finalHeader[@"User-Agent"] = httpUserAgent;
    finalHeader[@"s"] = [self setHeaderS:clientTime BodyDic:paraDic];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:[NsuserDefaultKeyName ShareInstance].token];
    token ? finalHeader[@"token"] = token : @"";
    
    return finalHeader;
}

/**
 生成http header 的 s 签名参数
 
 @param time clienttime时间
 @param body 请求body参数字典
 @return 返回生成的s签名
 */
- (NSString *)setHeaderS:(NSString *)time BodyDic:(NSDictionary *)body {
    NSString *dicStr = @"";
    if (body) {
        NSDictionary *bodyDic = @{@"data":body};
        dicStr = [dicStr dictionaryToJson:bodyDic];
    }
    NSString *formmerStr = [NSString stringWithFormat:@"%@%@%@",httpHeaderClientID,time,dicStr];
    return [formmerStr md5Mod32];
}


@end
