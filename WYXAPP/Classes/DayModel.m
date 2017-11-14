//
//  DayModel.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/20.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "DayModel.h"

@implementation DayModel
- (CGFloat)cellHeight {
    if (_cellHeight == 0) {
        
        CGFloat content_height = [self.content boundingRectWithSize:CGSizeMake(ViewWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil].size.height;
        _cellHeight = content_height+30;
        
       
        
    }
    return _cellHeight;
}
@end
