//
//  GlobalTool.h
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/19.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalTool : NSObject
+ (GlobalTool *)ShareInstance;

- (void)showAlertWith:(NSString *)message;

- (void)savePlistWithName:(NSString *)name data:(NSMutableArray *)dataArr;

- (NSMutableArray *)getPlistWithName:(NSString *)name;
- (NSString *)timeWithYearTimeIntervalString:(NSDate *)date;
- (NSString *)timeWithHourTimeIntervalString:(NSDate *)date;
- (void)showNoDataViewOn:(UIView *)superView withTitleString:(NSString *)title;

- (void)removeNoDataViewFrom:(UIView *)superView;
@end
