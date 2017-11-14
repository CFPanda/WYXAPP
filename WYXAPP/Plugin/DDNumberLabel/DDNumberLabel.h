//
//  DDNumberLabel.h
//  XXDNew
//
//  Created by 李胜书 on 2017/5/10.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DDNumberClickBlock)();

@interface DDNumberLabel : UIView

- (instancetype)initWithFrame:(CGRect)frame RemindText:(NSString *)remindText ClickText:(NSString *)clickText ClickBlock:(DDNumberClickBlock)clickBlock;

@end
