//
//  DayModel.h
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/20.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayModel : NSObject
@property (nonatomic, strong) NSString *timeDayYear;
@property (nonatomic, strong) NSString *timeHour;
//1,2,3,4
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign)CGFloat cellHeight;
@end
