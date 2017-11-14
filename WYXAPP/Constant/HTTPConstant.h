//
//  HTTPConstant.h
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/15.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//


#ifndef SERVER_SCHEME
#define SERVER_SCHEME @"http://"

#if DEBUG//测试环境

#define SERVER_HOST @"api.xiejianji.com"
#define SERVER_PORT @"/"
#define SERVER_PATH @"api/"

#else//生产环境

#define SERVER_HOST @"api.xiejianji.com"
#define SERVER_PORT @"/"
#define SERVER_PATH @"api/"


#endif
#endif

#ifndef HTTPConstant_h
#define HTTPConstant_h

/**
 登录注册
 */
#define USER_REGIST @"finances/hot"

#define USER_LOGIN @"finances/bids"

#endif /* HTTPConstant_h */
