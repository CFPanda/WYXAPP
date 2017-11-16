//
//  NoDataView.m
//  XXDLoan
//
//  Created by duanchuanfen on 2017/8/4.
//  Copyright © 2017年 李胜书. All rights reserved.
//

#import "NoDataView.h"
@interface NoDataView ()

@property (nonatomic ,strong)UIImageView *imageDefault;
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation NoDataView

+(instancetype)noDataViewWithFrame:(CGRect)frame title:(NSString *)titleString {
    return [[self alloc] initWithFrame:frame
                                 title:titleString];
}

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.titleString = title;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nothing"]];
    imageV.center = CGPointMake(self.center.x, self.center.y - 40);
    [self addSubview:imageV];
    self.imageDefault = imageV;
    
    UILabel *label = [UILabel new];
//    label.frame = CGRectMake(0, CGRectGetMaxY(imageV.frame), self.width, 50);
//    label.text = NSLocalizedString(self.titleString, @"");
//    label.textColor = grayPacketColor;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.titleLabel = label;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [super layoutSubviews];
    
//    self.imageDefault.center = CGPointMake(self.width * 0.5, self.height * 0.5 - 40);
//    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageDefault.frame), self.width, 60);
}
@end
