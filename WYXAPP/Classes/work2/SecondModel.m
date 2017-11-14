//
//  SecondModel.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/25.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "SecondModel.h"

@implementation SecondModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idNum": @"id"};
}
@end

@implementation SecondSmallModel
- (CGFloat)cellHeight {
    if (_cellHeight == 0) {
        
        CGFloat content_height = [self.content_english boundingRectWithSize:CGSizeMake(ViewWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight = content_height + 80 + 200;
        
        
        
    }
    return _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idNum": @"id",@"image_url":@"image-url",@"content_chinese":@"content-chinese",@"content_english":@"content-english",@"movie_info":@"movie-info",@"provider_name":@"provider-name",@"provider_item_key":@"provider-item-key",@"author_name": @"author-name",@"author_name_chinese": @"author-name-chinese",@"happened_at": @"happened-at"};
}
@end
