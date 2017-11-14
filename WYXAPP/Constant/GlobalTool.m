//
//  GlobalTool.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/19.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "GlobalTool.h"
#import "NoDataView.h"
@implementation GlobalTool
+ (GlobalTool *)ShareInstance {
    
    
    static GlobalTool *shareGlobalToolInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareGlobalToolInstance = [[self alloc] init];
    });
    return shareGlobalToolInstance;
}



- (void)showAlertWith:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Tip" message:message delegate:nil cancelButtonTitle:@"Confirm" otherButtonTitles:nil, nil];
    
    [alert show];

}


- (void)savePlistWithName:(NSString *)name data:(NSMutableArray *)dataArr{
    NSArray *patharray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path =  [patharray objectAtIndex:0];
    
    NSString *filepath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
   BOOL yes =  [dataArr writeToFile:filepath atomically:YES];

    if (!yes) {
        [[GlobalTool ShareInstance] showAlertWith:@"shibai"];
    }
   
}



- (NSMutableArray *)getPlistWithName:(NSString *)name{
    NSArray *patharray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path =  [patharray objectAtIndex:0];
    
    NSString *filepath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    NSMutableArray *dataArr = [NSMutableArray arrayWithContentsOfFile:filepath];
    return dataArr;
}


- (NSString *)timeWithYearTimeIntervalString:(NSDate *)date
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd "];
    
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

- (NSString *)timeWithHourTimeIntervalString:(NSDate *)date
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


- (void)showNoDataViewOn:(UIView *)superView withTitleString:(NSString *)title{
    NSArray *viewArr = [superView subviews];
    for (UIView *noDataView in viewArr) {
        if ([noDataView isKindOfClass:[NoDataView class]]) {
            return;
        }
    }
    NoDataView *noDataView = [NoDataView noDataViewWithFrame:superView.bounds title:title];
    [superView addSubview:noDataView];
    
}

- (void)removeNoDataViewFrom:(UIView *)superView {
    NSArray *viewArr = [superView subviews];
    for (UIView *noDataView in viewArr) {
        if ([noDataView isKindOfClass:[NoDataView class]]) {
            [noDataView removeFromSuperview];
        }
    }
}

@end
