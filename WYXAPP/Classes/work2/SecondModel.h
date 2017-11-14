//
//  SecondModel.h
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/25.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondModel : NSObject

@property (nonatomic, strong) NSString *idNo;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *attributes;

@end

@interface SecondSmallModel : NSObject
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content_chinese;
@property (nonatomic, strong) NSString *content_english;
@property (nonatomic, strong) NSString *movie_info;
@property (nonatomic, strong) NSString *provider_name;
@property (nonatomic, strong) NSString *provider_item_key;

@property (nonatomic, strong) NSString *author_name;
@property (nonatomic, strong) NSString *author_name_chinese;
@property (nonatomic, strong) NSString *happened_at;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong)NSArray *data;

@property (nonatomic, assign) BOOL isShouCang;
@end
